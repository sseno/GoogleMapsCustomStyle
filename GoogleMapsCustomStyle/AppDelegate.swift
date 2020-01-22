//
//  AppDelegate.swift
//  GoogleMapsCustomStyle
//
//  Created by Rohmat Suseno on 20/01/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("YOUR_API_KEY")
        
        return true
    }
}

