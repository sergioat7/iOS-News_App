//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    class func sharedAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor = UIColor.blue
        UINavigationBar.appearance().backgroundColor = UIColor.blue
        UINavigationBar.appearance().tintColor = UIColor.white
        UIBarButtonItem.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
//            NSAttributedString.Key.font : Font.titulos
        ]
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = UIColor.blue
        window?.makeKeyAndVisible()
        
        
        
        setRootViewController(MainViewController())
        
        
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
    
    
    func setRootViewController(_ newViewController: UIViewController) {
        let appNavigationController = AppNavigationController(rootViewController: newViewController)
        let navigationDrawerViewController = AppNavigationDrawerController(rootViewController: appNavigationController, leftViewController: nil, rightViewController: nil)
        
        
        if let view = window {
            UIView.transition(
                with: view,
                duration: 0.3,
                options: [.transitionCrossDissolve],
                animations: { () -> Void in
                    self.window?.rootViewController = navigationDrawerViewController
                    
            },
                completion: nil
            )
        }
        else {
            window?.rootViewController = navigationDrawerViewController
            
        }
    }

}
