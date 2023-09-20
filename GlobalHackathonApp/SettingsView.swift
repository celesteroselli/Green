//
//  SettingsView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/16/23.
//

import SwiftUI

struct SettingsView: View {
    //defines variables
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
    
    var body: some View {
        NavigationView {
            //sets up form
            Form {
                //section to change username
                Section {
                    TextField(name, text: $name)
                } header: {
                    Text("Name")
                    
                }
                
                //section that redirects to onboarding to re-link accounts
                Section {
                    //passes "false" for final variable, bc it should not show the final page, because you have back buttons to get back home
                    NavigationLink(destination: OnboardingView(name: $name, onboarding: $onboarding, alert: $alert, num_uber: $num_uber, num_lime: $num_lime, final: false)) {
                        Text("Link Accounts through Onboarding")
                    }
                } header: {
                    Text("Link Accounts")
                }
                
                
            }
            
        }.navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        
        
        
    }
    
    
}
