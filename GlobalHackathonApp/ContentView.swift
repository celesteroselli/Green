//**
//  ContentView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/12/23.
//
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var onboarding: Bool = true
    
    var body: some View {
        
        if onboarding {
            OnboardingView(onboarding: $onboarding)
        } else {
            HomePage()
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
