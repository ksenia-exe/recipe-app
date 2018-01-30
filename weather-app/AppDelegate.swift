//
//  AppDelegate.swift
//  project 7
//
//  Created by Ksenia Zhizhimontova on 11/21/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Create navigation controller with Posts VC as root
        let recipeNavigationController = UINavigationController(rootViewController: RecipeViewController())
        
        // Style it
        recipeNavigationController.navigationBar.barStyle = .black
        recipeNavigationController.navigationBar.barTintColor = .blogBlue
        recipeNavigationController.navigationBar.tintColor = .white
        recipeNavigationController.navigationBar.isTranslucent = false
        recipeNavigationController.navigationBar.shadowImage = UIImage()
        recipeNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Create UIWindow and set posts navigation controller as root
        let window = UIWindow()
        window.tintColor = .blogBlue
        window.rootViewController = recipeNavigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

