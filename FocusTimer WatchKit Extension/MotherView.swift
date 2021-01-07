//
//  MotherView.swift
//  FocusTimer WatchKit Extension
//
//  Created by kaiwen zhang on 1/1/21.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .startFocusTimer:
            StartFocusTimerView()
        case .overhead:
            OverheadView()
        case .warmup:
            WarmupView()
        case .cooldown:
            CooldownView()
        case .fullramp:
            FullrampView()
        case .overdrive:
            OverdriveView()
        case .justCountdown:
            JustCountdownView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
