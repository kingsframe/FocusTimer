//
//  ContentView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/29/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("60 min Timebox")
                .padding()
            
            NavigationLink(
                destination: OverheadView(),
                label: {
                    Text("Start")
                })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
