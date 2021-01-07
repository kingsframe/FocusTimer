//
//  FullrampView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 1/1/21.
//

import SwiftUI

let fullrampTime: CGFloat = 20*60

struct FullrampView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = fullrampTime
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func stopTimerAndGoToOverdrivePage() {
        isActive = false
        timeRemaining = fullrampTime
        viewRouter.currentPage = .overdrive
    }
    
    var body: some View {
        VStack {
            Text("Fullramp").padding()
            
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
                    stopTimerAndGoToOverdrivePage()
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
                stopTimerAndGoToOverdrivePage()
            }
        })
    }
}

struct FullrampView_Previews: PreviewProvider {
    static var previews: some View {
        FullrampView().environmentObject(ViewRouter())
    }
}
