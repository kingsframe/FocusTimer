//
//  OverheadView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/29/20.
//

import SwiftUI
import HealthKit

let overheadTime: CGFloat = 3*60

struct OverheadView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = overheadTime
    @State private var countdownToDate: Date?
    
    @State private var healthStore = HKHealthStore()
    @State private var session: HKWorkoutSession!
    @State private var builder: HKLiveWorkoutBuilder!
    
    @State private var typesToShare: Set = [
        HKQuantityType.workoutType()
    ]
    
    @State private var typesToRead: Set = [
        HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
    ]
    
    // Provide the workout configuration.
    func workoutConfiguration() -> HKWorkoutConfiguration {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        return configuration
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func stopTimerAndGoToWarmupPage() {
        isActive = false
        timeRemaining = overheadTime
        viewRouter.currentPage = .warmup
    }
    
    var body: some View {
        VStack {
            Text("Overhead").padding()
            
            let minutes = Int(timeRemaining) / 60 % 60
            let seconds = Int(timeRemaining) % 60
            Text("\(String(format:"%02i:%02i", minutes, seconds))").font(.largeTitle)
            
            HStack {
                Button(action: {
                    // Request authorization for those quantity types.
                    healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
                        // Handle errors here.
                    }
                    
                    do {
                        session = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration())
                        builder = session.associatedWorkoutBuilder()
                    } catch {
                        // Handle failure here.
                        return
                    }
                    
                    session.startActivity(with: Date())
                    
                    isActive.toggle()
                    //Add Overhead time to current date
                    countdownToDate = Date().addingTimeInterval(TimeInterval(overheadTime))
                }, label: {
                    Text("\(isActive ? "Pause" : "Go")")
                })
                
                Button(action: {
                    stopTimerAndGoToWarmupPage()
                }, label: {
                    Text("skip")
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            
            //Get difference between future time and current time
            timeRemaining = CGFloat(countdownToDate!.timeIntervalSince(Date()))

            if timeRemaining <= 0 {
                WKInterfaceDevice.current().play(.stop)
                stopTimerAndGoToWarmupPage()
            }
        })
    }
}

struct OverheadView_Previews: PreviewProvider {
    static var previews: some View {
        OverheadView().environmentObject(ViewRouter())
    }
}
