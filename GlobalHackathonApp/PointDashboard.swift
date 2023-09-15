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
                    Text("What are Green Points?")
                        .font(.title)
                        .padding(.all)
                    Image("+3")
                        .resizable()
                        .frame(width:400, height:400, alignment: .center)
                        
                    Text("Lora ipsum dolar Lora ipsum dolar Lora ipsum dolar Lora ipsum dolar Lora ipsum dolar Lora ipsum dolar Lora ipsum dolar")
                        .padding()
                    NavigationLink(destination: MapView()) {
                        Text("Map of Green Sites")
                    } .padding()
                    NavigationLink(destination: MapView()) {
                        Text("Leaderboard")
                    } .padding()
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
