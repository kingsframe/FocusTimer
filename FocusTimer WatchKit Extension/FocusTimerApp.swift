//
//  FocusTimerApp.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/29/20.
//

import SwiftUI

@main
struct FocusTimerApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MotherView().environmentObject(viewRouter)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
