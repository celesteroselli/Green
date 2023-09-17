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
                    TextField (
                        "What's your Lime phone number?",
                        text: $limePhoneNumberInputCurrent
                    )
                    
                    .keyboardType(.numberPad)
                    .frame(width: nil)
                    .onChange(of: limePhoneNumberInputCurrent) { newText in
                        if (limePhoneNumberInputCurrent.count == 3) {
                            limePhoneNumberInputCurrent = limePhoneNumberInputCurrent + "-"
                        } else if (limePhoneNumberInputCurrent.count == 7) {
                            limePhoneNumberInputCurrent = limePhoneNumberInputCurrent + "-"
                        }
                        if (limePhoneNumberInputCurrent.count == 10){
                            lime.sendLimeConfCode(phoneInput: limePhoneNumberInputCurrent) {
                                success in if success {
                                    print("success")
                                }
                            }
                            Button("Link Uber to Green", systemImage: "link.badge.plus") {
                                
                            }
                            .onTapGesture {
                                uber.doLogin(onCompletion: onUberLoginAttempt)
                            }
                            
                        }
                        
                        
                    }
                } header: {
                    Text("Link Accounts")
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


