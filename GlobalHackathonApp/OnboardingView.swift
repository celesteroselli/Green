//
//  LanchScreen.swift
//  GlobalHackathonApp
//
//  Created by Owen Daum on 9/15/23.
//

import SwiftUI
import ConfettiSwiftUI
import NavigationTransitions
struct OnboardingView: View {
    let impactFeedback = UIImpactFeedbackGenerator(style: .rigid)
    @State private var uberIsDone: Bool = false
    @State private var limeisDone: Bool = false
    @State private var counter = 0
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
    @State private var bouncing = false
    @State var code: String = ""
    @State var limeAccessToken: String = ""
    var welcomeToGreenText: String = ""
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
                
                HStack{
                    
                    Text ("Swipe to start")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.all)
                    Image(systemName: "arrow.right")
                        .frame(maxHeight:0.0000000000001, alignment: bouncing ? .bottom : .top)
                        .animation(Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: bouncing)
                        .onAppear {
                            self.bouncing.toggle()
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                VStack (spacing: 50) {
                    Text ("What should we call you?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    TextField("Enter your name", text: $name)
                        .padding(.all)
                    Text ("Just swipe when you're done.")
                }
                
                
                if name == "" {
                    Text("Welcome to Green!")
                        .font(.title2.bold())
                } else {
                    Text("Welcome to Green, \(name)!")
                        .font(.title2.bold())
                }
                
                Text("Green is the only app that rewards you for choosing eco-friendly alternative transportation!")
                    .font(.headline)
                    .padding(.all)
                
                
                Text("Let's Get Started!")
                    .font(.largeTitle.bold())
                
                if name == "" {
                    Text("We'll need to link your accounts.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.all)
                } else {
                    Text("\(name), we'll need to link your accounts.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.all)
                }
                
                
                
                VStack (spacing: 25){
                    if uberIsDone == false {
                        
                        Text("Connect your Uber account to get points for using rideshare.")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.all)
                    } else if uberIsDone == true {
                      
                            Text("Connect your Uber account to get points for using rideshare. \(Image(systemName: "checkmark"))")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.all)
                        
                    
                        
                            
                    }
                    Button("Link Uber to Green")
                    {
                        
                        uber.doLogin(onCompletion: onUberLoginAttempt)
                        impactFeedback.impactOccurred()
                        uberIsDone = true
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                    Text("If you don't have an Uber account, just swipe to the next page.")
                        .padding(.all)
                }
                
                
                VStack(spacing: 25){
                    
                    if limeisDone == true {
                        
                        Text("Connect your Lime account to get points for taking electric bikes and scooters. \(Image(systemName: "checkmark"))")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.all)
                    } else {
                        Text("Connect your Lime account to get points for taking electric bikes and scooters.")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.all)
                    }
                    
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
                                    limeisDone = true
                                    impactFeedback.impactOccurred()
                                }
                            }
                        }

                    }
                    TextField("Put in your 6-character code", text: $code)
                        .padding()
                        .keyboardType(.numberPad)
                        .frame(width: nil)
                    
                    
                    Text("If you don't have a Lime account, just swipe to the next page.")
                    
                        .padding(.all)
                }
                
                
                
                VStack {
                    Text("Thanks!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    NavigationLink(destination: HomePage(name: $name, alert: $alert, num_uber: $num_uber, num_lime: $num_lime)) {
                        Button(action: {
                            counter += 1
                            print(name)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                onboarding = false
                            }
                            
                        }) {
                            
                            Text("Let's do this!")
                                .font(.system(size: 25))
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                } .buttonStyle(.bordered)
                
                
                
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
        }
        
        
        .confettiCannon(counter: $counter, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
    }
    
}



