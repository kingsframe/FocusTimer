//
//  WarmupView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/30/20.
//

import SwiftUI

let warmupTime: CGFloat = 20*60

struct WarmupView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = warmupTime
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func stopTimerAndGoToCooldownPage() {
        isActive = false
        timeRemaining = warmupTime
        viewRouter.currentPage = .cooldown
    }
    
    var body: some View {
        VStack {
            Text("Warmup").padding()
            
            let minutes = Int(timeRemaining) / 60 % 60
            let seconds = Int(timeRemaining) % 60
            Text("\(String(format:"%02i:%02i", minutes, seconds))").font(.largeTitle)
            
            HStack {
                Button(action: {
                    isActive.toggle()
                }, label: {
                    Text("\(isActive ? "Pause" : "Go")")
                })
                
                Button(action: {
                    stopTimerAndGoToCooldownPage()
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
                stopTimerAndGoToCooldownPage()
            }
        })
    }
}

struct WarmupView_Previews: PreviewProvider {
    static var previews: some View {
        WarmupView().environmentObject(ViewRouter())
    }
}
