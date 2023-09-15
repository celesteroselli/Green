//
//  LanchScreen.swift
//  GlobalHackathonApp
//
//  Created by Owen Daum on 9/15/23.
//

import SwiftUI

struct LanchScreen: View {
    var body: some View {
        Text("Welcome back to Green, \(FirstName)!")
    }
}
public var uberUsername = "null"
public var uberPassword = "null"

struct OnboardingView: View {
    var body: some View {
        TabView {
            Image(systemName: "leaf.circle.fill")
                .foregroundColor(.green)
                .imageScale(.large)
            Text("Welcome to Green!")
          
            Text("Green is the only app that lets you get rewarded for helping the environment by choosing alternative transportation options!")
            .background(Color.green)
            
            .background(Color.green)
            Text("Let's Get Started!")
            
            .background(Color.green)
            
        }
    }
}

#Preview {
    LanchScreen()
}
