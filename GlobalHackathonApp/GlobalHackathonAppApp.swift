//
//  GlobalHackathonAppApp.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/12/23.
//

import SwiftUI

@main
struct GlobalHackathonAppApp: App {
    @AppStorage("onboarding") var onboarding: Bool = true
    var body: some Scene {
        WindowGroup {
            if onboarding == true {
                OnboardingView(onboarding: $onboarding)
            } else {
                ContentView()
            }
        }
    }
}
