//
//  HomePage.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/15/23.
//

import SwiftUI

struct HomePage: View {
    @Binding var name: String
    @Binding var alert: Bool
    @AppStorage("points") public var points: Int = 0
    @Binding var num_uber: Int
    @Binding var num_lime: Int
    
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
    
    func add_points() -> Int {
        //resets num_lime and num_uber to 0
        num_lime = 0
        num_uber = 0
        return (5 * num_lime) + num_uber
    }
    
    var body: some View {
        NavigationView() {
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
                Text(String("\(points)"))
                    .font(.system(size: 85))
                    .padding(.bottom)
                Text("Green Points Earned \(Image(systemName: "leaf.circle.fill"))")
                   
                    .font(.system(size: 26))
                Spacer()
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
                
                HStack {
                    NavigationLink(destination: MapView()) {
                        Text("Map")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: LeaderboardView(points: $points)) {
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
            }
            .alert(isPresented: $alert) {
                Alert(title: Text(get_message()), message: Text("You've been rewarded \(add_points()) points"), dismissButton: .default(Text("Got it!")) {
                    points += add_points()
                    print(add_points())
                })
                }
            }
        }
    }

//struct HomePage_Previews: PreviewProvider {
   // static var previews: some View {
   //     HomePage()
   // }
//}
