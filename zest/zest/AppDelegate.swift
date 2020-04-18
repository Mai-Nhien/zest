//
//  AppDelegate.swift
//  zest
//
//  Created by Mai on 4/6/20.
//  Copyright © 2020 Mai Dang. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSPlacesClient.provideAPIKey("AIzaSyCyfC5LF58QGmrEToRJQ7oG-2bZei_d2u4")
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(red: 199/255.0, green: 126/255.0, blue: 97/255.0, alpha: 0.85)
        navigationBarAppearace.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 17.0)!],
        for: .normal)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

