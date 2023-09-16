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
                Spacer()
                Text(String(points))
                    .font(.system(size: 45))
                Spacer()
                NavigationLink(destination: ScannerView(points: $points)) {
                        Text("Scan QR")
                    }
                Spacer()
                HStack {
                    NavigationLink(destination: HomePage().navigationBarBackButtonHidden(true)) {
                        Text("Home")
                            .padding()
                            .background(.gray)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: MapView()) {
                        Text("Map")
                            .padding()
                            .background(.gray)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: LeaderboardView(points: $points)) {
                        Text("Score")
                            .padding()
                            .background(.gray)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .padding()
                            .background(.gray)
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
