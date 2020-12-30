//
//  OverheadView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/29/20.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 3

struct OverheadView: View {
    
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Overhead").padding()
            
            let minutes = Int(timeRemaining) / 60 % 60
            let seconds = Int(timeRemaining) % 60
            Text("\(String(format:"%02i:%02i", minutes, seconds))").font(.largeTitle)
            
            HStack {
                Button(action: {
                    isActive.toggle()
                }, label: {
                    Text("\(isActive ? "Pause" : "Play")")
                })
                
//                Button(action: {
//                    isActive = false
//                    timeRemaining = defaultTimeRemaining
//                }, label: {
//                    Text("skip")
//                })
                NavigationLink(
                    destination: WarmupView(),
                    label: {
                        Text("Skip")
                    })
                
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                WKInterfaceDevice.current().play(.stop)
                isActive = false
                timeRemaining = defaultTimeRemaining
            }
        })
    }
}

struct OverheadView_Previews: PreviewProvider {
    static var previews: some View {
        OverheadView()
    }
}
