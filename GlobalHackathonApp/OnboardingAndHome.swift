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

struct OnboardingView: View {
    var uber: Uber
    @State var uberLoginMessage: String = ""
    @State var uberLoginMessageColor: Color = Color.gray
    
    func onUberLoginAttempt(success: Bool, message: String) {
        if success {
            self.uberLoginMessage = "Success"
            self.uberLoginMessageColor = Color.green
        } else {
            self.uberLoginMessage = "Error: " + message
            self.uberLoginMessageColor = Color.red
        }
    }
    
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
            
            Button("Set up Uber") {
                uber.doLogin(onCompletion: onUberLoginAttempt)
            }
            .background(Color.black)
            
            Text(uberLoginMessage)
                .background(uberLoginMessageColor)
        }
    }
}

#Preview {
    LanchScreen()
}
