//
//  SettingsView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/16/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var name: String
    var uber: Uber = Uber()
    var lime: Lime = Lime()
    @State var uberLoginMessage: String = ""
    @State var uberLoginMessageColor: Color = Color.gray
    @State var limePhoneNumberInputCurrent: String = ""
    @Binding var alert: Bool
    @Binding var num_uber: Int
    @Binding var num_lime: Int
    @State var onboarding: Bool = false
    
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
        NavigationView {
            Form {
                Section {
                    TextField(name, text: $name)
                } header: {
                    Text("Name")
                    
                }
                
                
                
                
                
                
                
                Section {
                    NavigationLink(destination: OnboardingView(name: $name, onboarding: $onboarding, alert: $alert, num_uber: $num_uber, num_lime: $num_lime, final: false)) {
                        Text("Link Accounts through Onboarding")
                    }
                } header: {
                    Text("Link Accounts")
                    Section{
                        Text("test")
                    }header: {
                        Text("Account Status")
                    }
                }
                
                
                
            }
            .navigationTitle("Settings")
        }
        
        
        
    }
    
    
}


//struct SettingsView_Previews: PreviewProvider {
//   static var previews: some View {
//      SettingsView()
//  }
//}


