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
    @Binding var type: String
    
    var body: some View {
        NavigationView() {
            VStack {
                Text("Welcome back to Green, \(name)!")
                    .padding()
                    .font(.title)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(String(points))
                    .font(.system(size: 85))
                    .padding(.bottom)
                Text("Green Points Earned")
                    .font(.system(size: 26))
                Spacer()
                NavigationLink(destination: ScannerView(points: $points)) {
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
            }.alert(isPresented: $alert) {
                Alert(title: Text(type == "lime" ? "+5 points" : "+1 point"), message: Text(type == "lime" ? "You rented a Lime e-bike/scooter!" : "You took an Uber!"), dismissButton: .default(Text("Got it!")) {
                    if type == "lime" {
                        points += 5
                    } else {
                        points += 1
                    }
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
