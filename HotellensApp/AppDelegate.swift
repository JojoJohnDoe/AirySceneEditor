//
//  AppDelegate.swift
//  HotellensApp
//
//  Created by Johannes Karow on 26/08/14.
//  Copyright (c) 2014 Hotellens. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        AERecord.loadCoreDataStack()
        
        // ---Google Analytics initialisation code---
        HLSAnalyticsSettings()
        
        // Setup userdefaults
        UserDefaultDefaults()
        
        // temp disable saved login
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("userHash")
        // Show LoginScreen if no logged out
        if (APIManager.sharedInstance.loginState.isLoggedIn){
            // Check if User Hash is in NSUserDefaults and if so dismiss loginView
            //showLoginScreen(animated: true)
            // TODO: was ist wenn der Hash invalide ist? Fehler behandeln!
        }else{
            showLoginScreen(animated: true)
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func showLoginScreen(animated flag: Bool){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("Login Screen") as! HLSLoginViewController
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }
}

