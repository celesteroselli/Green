//
//  AchievementsView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/16/23.
//

import SwiftUI

//defines Card (achievement) with ID, name, and points
struct Card: Identifiable {
    let id = UUID()
    var name: String
    var pts: Int
}

struct AchievementsView: View {
    @Binding var points: Int
    
    //defines each achievement with a title and points required to earn it
    let achievements = [
        Card(name: "Just getting started!", pts: 5),
        Card(name: "We're on our way!", pts: 15),
        Card(name: "Nice job!", pts: 25),
        Card(name: "Halfway to 100!", pts: 50),
        Card(name: "3/4 there!", pts: 75),
        Card(name: "Nature Lover", pts: 100),
        Card(name: "Clean-air Commander", pts: 150),
        Card(name: "Transportation Teacher", pts: 300),
        Card(name: "Nature Master", pts: 1000),
        Card(name: "Eco-Warrier", pts: 3000)
    ]
    
    //checks how many achievements have been completed, and divides that number by number of achievements (10) to get percentage of achievements completed
    //used as value in ProgressView
    func check_status() -> Double {
        var achievement_won: Int = 0
        for achievement in achievements {
            if points >= achievement.pts {
                achievement_won = achievement_won + 1
            }
        }
        return Double(achievement_won) / Double(10)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //shows ProgressView with percentage of achievements completed
                ProgressView(value: check_status())
                //ability to scroll throw achievements
                ScrollView {
                    VStack {
                        //for each achievement, shows card with name and points at which it is achieved
                        ForEach(achievements) { achievement in
                            VStack{
                                Text(achievement.name)
                                Text("Achieved at \(achievement.pts) points")
                            }
                            .padding()
                            .frame(width: 350)
                            //if you have earned enough points to achieve it, turn green
                            //If not, background color is gray
                            .background(points >= achievement.pts ? Color.accentColor : .gray)
                            .cornerRadius(8)
                            .padding()
                        }
                    }
                }
            }
        }.navigationTitle("Achievements")
    }
}
