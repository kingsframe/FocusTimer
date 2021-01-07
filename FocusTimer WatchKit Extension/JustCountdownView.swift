//
//  JustCountdownView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 1/7/21.
//

import SwiftUI

let justCountdownTime: CGFloat = 3600

struct JustCountdownView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = justCountdownTime
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func stopTimerAndGoToStartFocusTimerPage() {
        isActive = false
        timeRemaining = justCountdownTime
        viewRouter.currentPage = .startFocusTimer
    }
    
    var body: some View {
        VStack {
            Text("Just Countdown").padding()
            
            let hours = Int(timeRemaining) / 3600
            let minutes = Int(timeRemaining) / 60 % 60
            let seconds = Int(timeRemaining) % 60
            Text("\(String(format:"%02i:%02i:%02i", hours, minutes, seconds))").font(.largeTitle)
            
            HStack {
                Button(action: {
                    isActive.toggle()
                }, label: {
                    Text("\(isActive ? "Pause" : "Go")")
                })
                
                Button(action: {
                    stopTimerAndGoToStartFocusTimerPage()
                }, label: {
                    Text("skip")
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                WKInterfaceDevice.current().play(.stop)
                stopTimerAndGoToStartFocusTimerPage()
            }
        })
    }
}

struct JustCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        JustCountdownView()
    }
}
