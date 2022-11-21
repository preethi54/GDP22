//
//  AppDelegate.swift
//  SmartParking_GDP
//
//  Created by Jadhav,Preethi Eshwarlal on 11/5/22.
//

import UIKit
import GoogleMaps
import FirebaseCore

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        GMSServices.setMetalRendererEnabled(true)
        GMSServices.provideAPIKey("AIzaSyDaOdQrv2ZJXzBsOwCrDhBr7T-tt_EfN7I")
        
        FirebaseApp.configure()
        return true
    }

    @available(iOS 13.0, *)
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
       // @available(iOS 13.0, *)
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    


}

