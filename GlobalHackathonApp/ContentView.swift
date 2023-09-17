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
    @AppStorage("type") var type: String = ""
    
    func should_alert() -> Binding<Bool> {
        //check if user is logged into uber
        //check if user is logged into lime
        //if user's uber rides have increased, alert = true
        //type = "uber"
        //if user's lime rides have increased, alert = true
        //type = "lime"
        //else, alerts = false
        type = ""
        alert = false
        return $alert
    }
    func get_type() -> Binding<String> {
        return $type
    }
    
    var body: some View {
        
        if onboarding {
            OnboardingView(name: $name, onboarding: $onboarding, alert: $alert, type: get_type())
        } else {
            //if user's uber rides have increased, alert = true
            //if user's lime rides have increased, alert = true
            //else, alerts = false
            HomePage(name: $name, alert: should_alert(), type: get_type())
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
