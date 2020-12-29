//
//  FocusTimerApp.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 12/29/20.
//

import SwiftUI

@main
struct FocusTimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
