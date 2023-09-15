//
//  Uber.swift
//  GlobalHackathonApp
//
//  Created by Liam Loughead on 9/14/23.
//

import Foundation
import UberCore
import UberRides

struct RecentRide {
    var pickupLocation: String
    var destination: String
    var lengthInMiles: Int
    var timeFinished: Date
}

struct Uber {
    func doLogin(onCompletion: @escaping (Bool, String) -> Void) -> Void {
        let loginManager = LoginManager()
        loginManager.login(requestedScopes:[.request], completion: { accessToken, error in
            // Completion block. If accessToken is non-nil, you’re good to go
            // Otherwise, error.code corresponds to the RidesAuthenticationErrorType that occured
            if (accessToken != nil) {
                onCompletion(true, "Success!")
            } else {
                print(error!)
                onCompletion(false, "Error Code: " + (error!.localizedDescription))
            }
        })
    }
    
    func getRecentRides(onFinish: @escaping (TripHistory?, Response) -> Void) -> Void {
        let ridesClient = try RidesClient();
        if !ridesClient.hasServerToken{return
        ridesClient.fetchTripHistory(completion: onFinish)
    }
}
