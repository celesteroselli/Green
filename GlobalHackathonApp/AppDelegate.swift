//
//  AppDelegate.swift
//  GlobalHackathonApp
//
//  Created by Liam Loughead on 9/14/23.
//

import Foundation
import UberCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Uncomment if your app is registered in China
        //Configuration.setRegion(.China)
        
        // Make requests to sandbox by default
        Configuration.shared.isSandbox = true
        
        // Handle incoming SSO Requests
        _ = UberAppDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    @available(iOS 9, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let handledUberURL = UberAppDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] as Any)
        
        return handledUberURL
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handledUberURL = UberAppDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handledUberURL
    }
}
