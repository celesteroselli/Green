//
//  HomePage.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/15/23.
//

import SwiftUI

struct HomePage: View {
    @AppStorage("name") public var name: String = "User"
    @AppStorage("points") public var points: Int = 0
    
    var body: some View {
        NavigationView() {
            VStack {
                Text("Welcome back to Green, \(name)!")
                    .padding()
                    .font(.title)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(String(points))
                    .font(.system(size: 45))
                    .padding(.bottom)
                Text("Green Points Earned")
                Spacer()
                NavigationLink(destination: ScannerView(points: $points)) {
                        Text("Scan QR")
                        .font(.title)
                        .padding()
                        .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.accentColor, lineWidth: 3)
                                )
                    }
                Spacer()
                HStack {
                    NavigationLink(destination: HomePage().navigationBarBackButtonHidden(true)) {
                        Text("Home")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: MapView()) {
                        Text("Map")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: LeaderboardView(points: $points)) {
                        Text("Achievements")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
