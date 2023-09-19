//**
//  ContentView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/12/23.
//
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var onboarding: Bool = true
    @AppStorage("name") var name: String = ""
    @AppStorage("alert") var alert: Bool = false
    @AppStorage("num_uber") var num_uber: Int = 0
    @AppStorage("num_lime") var num_lime: Int = 0
    @AppStorage("lastUberRide") var lastUberRide: Double = 0.0
    @AppStorage("lastLimeRide") var lastLimeRide: Double = 0.0
    @AppStorage("limeToken") var limeAccessToken: String = ""
    @AppStorage("limeCookie") var limeCookie: String = ""
    var uber: Uber = Uber()
    var lime: Lime = Lime()
    
    func should_alert() -> Binding<Bool> {
        //check if user logged in to uber
        //if so, check if new ride
        //if so, for each new ride, add 1 to num_uber, and make alert = true
        num_uber = 0
        num_lime = 0
        alert = false
        uber.getRecentRides(onFinish: {history, serverResponse in
            history?.history.forEach({ride in //Go through each last ride returned
                //If this ride ended before the last remembered ride ended, then give them a point
                if (ride.endTime?.timeIntervalSince1970 ?? 0.0 > lastUberRide) {
                    num_uber += 1
                    lastUberRide = ride.endTime!.timeIntervalSince1970 //Set the last ride time remembered to the most recent ride
                }
            })
        })
        //check if user logged in to lime
        //if so, check if new rental
        //if so, for each new rental, add 1 to num_lime, and make alert = true
        lime.getLastRideTime(token: limeAccessToken, cookie: limeCookie, onDone: { lastRideTime in
            if (lastLimeRide < lastRideTime) {
                num_lime += 1
            }
        })
        alert = (num_lime != 0) || ( num_uber != 0)
        return $alert
    }
    
    var body: some View {
        //checks onboarding variable to see if it should show onboarding view (for first time) or home page view
        //passes stored variables
        if onboarding {
            OnboardingView(name: $name, onboarding: $onboarding, alert: $alert, num_uber: $num_uber, num_lime: $num_lime, final: true)
        } else {
            //if user's uber rides have increased, alert = true
            //else, alerts = false
            HomePage(name: $name, alert: should_alert(), num_uber: $num_uber, num_lime: $num_lime)
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
