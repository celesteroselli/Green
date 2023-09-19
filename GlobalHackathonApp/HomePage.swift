//
//  HomePage.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/15/23.
//

import SwiftUI
import UberRides
import UberCore

struct HomePage: View {
    //declares variables, and binds other stored variables from ContentView
    @Binding var name: String
    @Binding var alert: Bool
    @AppStorage("points") public var points: Int = 0
    @AppStorage("lastUberRide") public var lastUberRide: Double = Date.now.timeIntervalSince1970
    @AppStorage("limeToken") public var limeToken: String = ""
    @AppStorage("limeCookie") public var limeCookie: String = ""
    @Binding var num_uber: Int
    @Binding var num_lime: Int
    var uber: Uber = Uber()
    var lime: Lime = Lime()
    
    //gets alert message based off of how many new uber/lime rides have been taken
    func get_message() -> String {
        var message: String = "You took "
        if num_lime > 0 {
            message = message + "\(num_lime) Lime rentals"
        }
        if num_lime > 0 && num_uber > 0 {
            message = message + " and "
        }
        if num_uber > 0 {
            message = message + "\(num_uber) Ubers"
        }
        return message
    }
    
    //calculates points to add based off of how many new uber/lime rides have been taken
    func add_points() -> Int {
        //resets num_lime and num_uber to 0
        num_lime = 0
        num_uber = 0
        return (5 * num_lime) + num_uber
    }
    
    var body: some View {
        NavigationView() {
            //shows welcome title based, with name greeting if you have entered your name
            VStack {
                if name == "" {
                    Text("Welcome back to Green!")
                        .padding()
                        .font(.title)
                        .multilineTextAlignment(.center)
                } else {
                    Text("Welcome back to Green, \(name)!")
                        .padding()
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                
                //shows total # of points
                Text(String("\(points)"))
                    .font(.system(size: 85))
                    .padding(.bottom)
                Text("Green Points Earned \(Image(systemName: "leaf.circle.fill"))")
                
                    .font(.system(size: 26))
                Spacer()
                
                //link to scan public transit QR codes
                NavigationLink(destination: ScannerView(points: $points, name: $name, alert: $alert, num_uber: $num_uber, num_lime: $num_lime)) {
                    Text("Scan QR Code")
                        .font(.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 3)
                        )
                }
                Spacer()
                
                //bottom navigation menu with navigation links to Map, Achievements, and Settings
                HStack {
                    NavigationLink(destination: MapView()) {
                        Text("Map")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: AchievementsView(points: $points)) {
                        HStack {
                            Text("Achievements")
                        }
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    NavigationLink(destination: SettingsView(name: $name)) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                }
            } //settings for alert that will show if there are new uber/lime rides
            .alert(isPresented: $alert) {
                Alert(title: Text(get_message()), message: Text("You've been rewarded \(add_points()) points"), dismissButton: .cancel(Text("Got it!")) {
                    points += add_points()
                    print(add_points())
                })
            }
            .onAppear {
                //Start callbacks to check for recent rides
                uber.getRecentRides(onFinish: {history, serverResponse in
                    history?.history.forEach({ride in //Go through each last ride returned
                        //If this ride ended before the last remembered ride ended, then give them a point
                        if (ride.endTime?.timeIntervalSince1970 ?? 0.0 > lastUberRide) {
                            num_uber += 1
                            lastUberRide = ride.endTime!.timeIntervalSince1970 //Set the last ride time remembered to the most recent ride
                        }
                    })
                })
            }
        }
    }
}
