//
//  CooldownView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 1/1/21.
//

import SwiftUI

let cooldownTime: CGFloat = 7*60

struct CooldownView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = cooldownTime
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func stopTimerAndGoToFullrampPage() {
        isActive = false
        timeRemaining = cooldownTime
        viewRouter.currentPage = .fullramp
    }
    
    var body: some View {
        VStack {
            Text("Cooldown").padding()
            
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
                    stopTimerAndGoToFullrampPage()
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
                stopTimerAndGoToFullrampPage()
            }
        })
    }
}

struct CooldownView_Previews: PreviewProvider {
    static var previews: some View {
        CooldownView().environmentObject(ViewRouter())
    }
}
