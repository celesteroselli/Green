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
    @AppStorage("name") var name: String = ""
    @AppStorage("alert") var alert: Bool = false
    @AppStorage("num_uber") var num_uber: Int = 0
    @AppStorage("num_lime") var num_lime: Int = 0
    
    func should_alert() -> Binding<Bool> {
        //check if user logged in to uber
        //if so, check if new ride
        //if so, for each new ride, add 1 to num_uber, and make alert = true
        //check if user logged in to lime
        //if so, check if new rental
        //if so, for each new rental, add 1 to num_lime, and make alert = true
        num_uber = 0
        num_lime = 0
        alert = false
        return $alert
    }
    
    var body: some View {
        //checks onboarding variable to see if it should show onboarding view (for first time) or home page view
        //passes stored variables
        if onboarding {
            OnboardingView(name: $name, onboarding: $onboarding, alert: $alert, num_uber: $num_uber, num_lime: $num_lime, final: true)
        } else {
            //if user's uber rides have increased, alert = true
            //if user's lime rides have increased, alert = true
            //else, alerts = false
            HomePage(name: $name, alert: should_alert(), num_uber: $num_uber, num_lime: $num_lime)
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
