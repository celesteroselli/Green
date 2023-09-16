//
//  LanchScreen.swift
//  GlobalHackathonApp
//
//  Created by Owen Daum on 9/15/23.
//

import SwiftUI

struct OnboardingView: View {
    
    var uber: Uber = Uber()
    var lime: Lime = Lime()
    @State public var needsOnboarding: Bool = true
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
            
            TabView {
                
                
                Text ("Swipe to start \(Image(systemName: "arrow.right"))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Image(systemName: "leaf.circle.fill")
                    .renderingMode(.template)
                    .resizable(capInsets: EdgeInsets(top: 100.0, leading: 100.0, bottom: 100.0, trailing: 100.0), resizingMode: .stretch)
                    .foregroundColor(Color.green)
                    .padding(.all)
                    .frame(width: 6.0, height: 7.0)
                    .imageScale(.large)
                //         Button("linkGreen+Uber") {
                //nothingyet
                //             }
                
                
                
                
                Text("Welcome to Green!")
                    .font(.title2.bold())
                
                Text("Green is the only app that rewards you for choosing eco-friendly alternative transportation!")
                    .font(.headline)
                    .padding(.all)
                
                
                Text("Let's Get Started!")
                    .font(.largeTitle.bold())
                /*
                 TextField("Enter Your Lime Phone Number", text: $limePhoneNumberInputCurrent) {
                 .keyboardType(.phonePad)
                 .onChange(of: limePhoneNumberInputCurrent) { newText in
                 if (limePhoneNumberInputCurrent.count == 3) {
                 limePhoneNumberInputCurrent = limePhoneNumberInputCurrent + "-"
                 } else if (limePhoneNumberInputCurrent.count == 8) {
                 limePhoneNumberInputCurrent = limePhoneNumberInputCurrent + "-"
                 }
                 }
                 .onSubmit {
                 lime.sendLimeConfCode(phoneInput: limePhoneNumberInputCurrent) { success in
                 if success {
                 print("success")
                 }
                 }
                 }
                 */
                Button("Link Uber to Green") {
                    
                    uber.doLogin(onCompletion: onUberLoginAttempt)
                    needsOnboarding = false
                }
                .buttonStyle(.borderedProminent)
                var READMETOO = "This button is throwing off the onboarding because of a bug. (idk why)"
                //  Button("Link Uber to Green \(Image(systemName: "link.badge.plus"))") {
                //thisbuttonisdead
                //  uber.doLogin(onCompletion: onUberLoginAttempt)
                //  Button("linkGreen+Uber") {
                //nothingyet
                //      }
                // Button("Link Uber to Green \(Image(systemName: "link.badge.plus"))") {
                //thisbuttonisdead
                //   uber.doLogin(onCompletion: onUberLoginAttempt)
                //       }
                
                
                TextField (
                    "What's your Lime phone number?",
                    text: $limePhoneNumberInputCurrent
                )
                .padding()
                
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
                }
                
             
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    //      Text(uberLoginMessage)
                    //       .background(uberLoginMessageColor)
                    
                    
                 
                    
                    
                    
                    
                    
                    
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
        //#Preview {
        //    LanchScreen()
        //}
        
    }
    //struct OnboadingView_Previews: PreviewProvider {
        //static var previews: some View {
        //    OnboardingView()
       // }
   // }
}
