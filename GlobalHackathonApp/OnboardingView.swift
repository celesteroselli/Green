//
//  LanchScreen.swift
//  GlobalHackathonApp
//
//  Created by Owen Daum on 9/15/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var name: String
    @Binding var onboarding: Bool
    @State var username: String = ""
    @Binding var alert: Bool
    @Binding var num_uber: Int
    @Binding var num_lime: Int
    
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
            
            TabView {
                
                
                Text ("Swipe to start \(Image(systemName: "arrow.right"))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                //         Button("linkGreen+Uber") {
                //nothingyet
                //             }
                
                
                VStack (spacing: 50) {
                    Text ("What should we call you?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    TextField("Enter your name", text: $name)
                        .padding(.all)
                    Text ("Just swipe when you're done.")
                }
                
                
                Text("Welcome to Green, \(name)!")
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
                
                Text("\(name), we'll need you to link your accounts.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.all)
                
                VStack (spacing: 25){
                    Text("Connect your Uber account to get points for using rideshare.")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Button("Link Uber to Green \(Image(systemName: "link.badge.plus"))") {
                    
                        uber.doLogin(onCompletion: onUberLoginAttempt)
                        
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                    Text("If you don't have an Uber account, just swipe to the next page.")
                        .padding(.all)
                }
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
                
                VStack(spacing: 25){
                    Text("Next, connect your Lime account.")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("You'll get points for taking electric bikes and scooters.")
                TextField (
                    "What's your Lime phone number?",
                    text: $limePhoneNumberInputCurrent
                )
                .padding()
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
                    }
                    
                  
                    
                }
                    
                    
                    Text("If you don't have a Lime account, just swipe to the next page.")
                        
                        .padding(.all)
                }
                
                
                
                
                //      Text(uberLoginMessage)
                //       .background(uberLoginMessageColor)
                
                
                VStack {
                    NavigationLink(destination: HomePage(name: $name, alert: $alert, num_uber: $num_uber, num_lime: $num_lime)) {
                        Button("Let's do this!"){
                    print(name)
                            onboarding = false
                        }
                    }
                }
                
                
                
                
                
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
    }
    
    //#Preview {
    //    LanchScreen()
    //}
    
    
    //struct OnboadingView_Previews: PreviewProvider {
    //static var previews: some View {
    //    OnboardingView()
    // }
    // }
}
