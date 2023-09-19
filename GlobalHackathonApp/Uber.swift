//
//  Uber.swift
//  GlobalHackathonApp
//
//  Created by Liam Loughead on 9/14/23.
//

import Foundation
import UberCore
import UberRides

struct Uber {
    func doLogin(onCompletion: @escaping (Bool, String) -> Void) -> Void {
        let loginManager = LoginManager()
        loginManager.login(requestedScopes:[.history], completion: { accessToken, error in
            // Completion block. If accessToken is non-nil, you’re good to go
            // Otherwise, error.code corresponds to the RidesAuthenticationErrorType that occured
            if (accessToken != nil) {
                onCompletion(true, "Success!")
            } else {
                print(error!)
                onCompletion(false, "Error: " + (error!.localizedDescription))
            }
        })
    }
    
    func isLoggedIn() -> Bool { return RidesClient().hasServerToken}
    
    //Returns the last 5 rides in a callback called onFinish
    func getRecentRides(onFinish: @escaping (TripHistory?, Response) -> Void) -> Void {
        let ridesClient = RidesClient();
        if !ridesClient.hasServerToken{
            print("getRecentRides called but no Uber Token")
            return
        }
        ridesClient.fetchTripHistory(completion: onFinish)
    }
}
