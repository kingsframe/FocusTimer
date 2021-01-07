//
//  ContentView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/29/20.
//

import SwiftUI

struct StartFocusTimerView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        VStack {
            Text("60 min Timebox")
                .padding()
            
            Button(action: {
                viewRouter.currentPage = .overhead
            }, label: {
                Text("Start Focus")
            })
            Button(action: {
                viewRouter.currentPage = .justCountdown
            }, label: {
                Text("Just Countdown")
            })
        }
        
    }
}

struct StartFocusTimerView_Previews: PreviewProvider {
    static var previews: some View {
        StartFocusTimerView().environmentObject(ViewRouter())
    }
}
