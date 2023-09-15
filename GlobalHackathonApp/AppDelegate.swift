//
//  AppDelegate.swift
//  GlobalHackathonApp
//
//  Created by Liam Loughead on 9/14/23.
//

import Foundation
import UberCore
    
@available(iOS 9, *)
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    let handledUberURL = UberAppDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] as Any)

    return handledUberURL
}
    
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    let handledUberURL = UberAppDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)

    return handledUberURL
}
