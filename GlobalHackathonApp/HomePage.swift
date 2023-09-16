//
//  HomePage.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/15/23.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView() {
            VStack {
                Text("Welcome back to Green, \(FirstName)!")
                    .padding()
                    .font(.title)
                Spacer()
                Text("# of Green Points")
                Spacer()
                HStack {
                    NavigationLink(destination: HomePage()) {
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
                    NavigationLink(destination: MapView()) {
                        Text("Score")
                            .padding()
                            .background(.gray)
                            .cornerRadius(8)
                    }
                    NavigationLink(destination: MapView()) {
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
