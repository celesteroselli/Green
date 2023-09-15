//
//  PointDashboard.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI

struct PointDashboard: View {
    var body: some View {
        VStack {
            NavigationView {
                VStack{
                    Text("Point Dashboard")
                        .font(.title)
                    NavigationLink(destination: MapView()) {
                        Text("Map View")
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PointDashboard_Previews: PreviewProvider {
    static var previews: some View {
        PointDashboard()
    }
}
