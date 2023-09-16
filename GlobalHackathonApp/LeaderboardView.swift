//
//  LeaderboardView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/16/23.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var name: String
    var pts: Int
}

struct LeaderboardView: View {
    @Binding var points: Int
    
    let achievements = [
        Card(name: "Achievement #1", pts: 5),
        Card(name: "Achievement #2", pts: 7),
        Card(name: "Achievement #3", pts: 10)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(achievements) { achievement in
                        VStack{
                            Text(achievement.name)
                            Text("Achieved at \(achievement.pts) points")
                        }
                        .padding()
                        .frame(width: 350)
                        .background(points >= achievement.pts ? Color.accentColor : .gray)
                        .cornerRadius(8)
                        .padding()
                    }
                }
            }
        }.navigationTitle("Achievements")
    }
    }

//struct LeaderboardView_Previews: PreviewProvider {
 //   static var previews: some View {
 //       LeaderboardView()
  //  }
//}
