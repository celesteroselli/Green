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
    //define variables
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
    @State var limePhoneNumberColor: Color = Color.gray
    @State var limePhoneNumberInputCurrent: String = ""
    @State private var bouncing = false
    @State var code: String = ""
    @AppStorage("limeToken") var limeAccessToken: String = ""
    @AppStorage("limeCookie") var limeCookie: String = ""
    var welcomeToGreenText: String = ""
    @State var final:Bool = true
    
    func onUberLoginAttempt(success: Bool, message: String) {
        //Callback for uber login function. Alerts the user if it was successful or not
        if success {
            self.uberLoginMessage = "Success"
            self.uberLoginMessageColor = Color.green
            impactFeedback.impactOccurred()
            uberIsDone = true
        } else {
            self.uberLoginMessage = message
            self.uberLoginMessageColor = Color.red
            impactFeedback.impactOccurred()
            uberIsDone = false
        }
    }
    
    
    var body: some View {
        //TabView with different pages that the user will swipe through during onboarding
        NavigationView {
            TabView {
                //first tab
                HStack{
                    Text ("Swipe to start")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(30)
                    Image(systemName: "arrow.right")
                        .frame(maxHeight:0.0000000000001, alignment: bouncing ? .bottom : .top)
                        .animation(Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: bouncing)
                        .onAppear {
                            self.bouncing.toggle()
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                }
                //second tab
                VStack (spacing: 50) {
                    Text ("What should we call you?")
                        .font(.largeTitle)
                        .padding(30)
                        .fontWeight(.bold)
                    TextField("Enter your name", text: $name)
                        .padding(30)
                    Text ("Just swipe when you're done.")
                        .padding(30)
                }
                
                //third tab
                
                //support for null value for name
                if name == "" {
                    Text("Welcome to Green!")
                        .font(.title2.bold())
                        .padding(30)
                } else {
                    Text("Welcome to Green, \(name)!")
                        .font(.title2.bold())
                        .padding(30)
                }
                
                //fourth tab
                Text("Green is the only app that rewards you for choosing eco-friendly alternative transportation!")
                    .font(.headline)
                    .padding(30)
                
                //fifth tab
                Text("Let's Get Started!")
                    .font(.largeTitle.bold())
                    .padding(30)
                
                //sixth tab
                
                //support for null value for name
                if name == "" {
                    Text("We'll need to link your accounts.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(30)
                } else {
                    Text("\(name), we'll need to link your accounts.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(30)
                }
                
                //seventh tab
                VStack (spacing: 25){
                    //adds checkmark if Uber integration is complete
                    if uberIsDone == false {
                        Text("Connect your Uber account to get points for using rideshare.")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(30)
                    } else if uberIsDone == true {
                            Text("Connect your Uber account to get points for using rideshare. \(Image(systemName: "checkmark"))")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(30)
                     
                    }
                    Button("Link Uber to Green")
                    {
                        //Call the uber login function with the above function as a callback
                        uber.doLogin(onCompletion: onUberLoginAttempt)
                    }
                    
                    .buttonStyle(.borderedProminent)
                    Text(uberLoginMessage)
                        .foregroundColor(uberLoginMessageColor)
                        .padding(30)
                       
                    
                    Text("If you don't have an Uber account, just swipe to the next page.")
                        .padding(30)
                    
                //eigth tab
                }
                VStack(spacing: 25){
                    //adds checkmark if lime integration is complete
                    if limeisDone == true {
                        
                        Text("Connect your Lime account to get points for taking electric bikes and scooters. \(Image(systemName: "checkmark"))")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(30)
                    } else {
                        Text("Connect your Lime account to get points for taking electric bikes and scooters.")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(30)
                    }
                    
                    
                    TextField (
                        "What's your Lime phone number?",
                        text: $limePhoneNumberInputCurrent
                            
                    )
                    .padding(30)
                    .keyboardType(.numberPad)
                    .frame(width: nil)
                    .onChange(of: limePhoneNumberInputCurrent) { newText in
                        //Automatically add dashes to the phone number input, and automatically send request when the phone number is completely inputed
                        if (limePhoneNumberInputCurrent.count == 3) {
                            limePhoneNumberInputCurrent = limePhoneNumberInputCurrent + "-"
                        } else if (limePhoneNumberInputCurrent.count == 7) {
                            limePhoneNumberInputCurrent = limePhoneNumberInputCurrent + "-"
                        }
                        if (limePhoneNumberInputCurrent.count == 12){
                            //Send confirmation code request
                            lime.sendLimeConfCode(phoneInput: limePhoneNumberInputCurrent) {
                                success in if success {
                                    print("lime phone number submission success")
                                    limePhoneNumberColor = Color.green
                                    //Colors the phone number text green if the confirmation request is submitted
                                } else {
                                    limePhoneNumberColor = Color.red
                                    //Colors the phone number text red if the confirmation request returns an invalid status code
                                }
                            }
                        }

                    }
                    .foregroundColor(limePhoneNumberColor)
                    TextField("Put in your 6-character code", text: $code)
                        .padding(30)
                        .keyboardType(.numberPad)
                        .frame(width: nil)
                        .onChange(of: code) { newText in
                            if (code.count == 6) {
                                //Auto submit the lime code when inputted
                                lime.verifyLimeCode(code: code, phoneInput: limePhoneNumberInputCurrent) { token, sessionCookie in
                                    //Store the token and cookie
                                    limeAccessToken = token
                                    limeCookie = sessionCookie
                                    limeisDone = true
                                    impactFeedback.impactOccurred()
                                    print("Lime login finished, token: \(token), cookie: \(sessionCookie)")
                                }
                            }
                        }
                    Text("If you don't have a Lime account, just swipe to the next page.")
                    
                        .padding(30)
                }
                
                //ninth (final) tab
                if final {
                    //if accessing through settings to change account info, then no need to show this page, because you have a back button from NavigationView to redirect home
                    VStack {
                        Text("Thanks!")
                            .padding(30)
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
                                    .padding(30)
                            }
                            
                        }
                        
                    } .buttonStyle(.bordered)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .tabViewStyle(.page(indexDisplayMode: .never))
        } //displays confetti cannon effect when you press the final button!
        .confettiCannon(counter: $counter, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
    }
    
}



