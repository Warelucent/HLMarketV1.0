//
//  AppDelegate.swift
//  HLMarketV1.0
//
//  Created by @xwy_brh on 08/03/2017.
//  Copyright © 2017 @egosuelee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white;
        
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        if let guide: [String:String] = userDefault.value(forKey: "GuideHistory") as! [String:String]?, guide["tag"] == "1",guide["version"] == version{
            let rootVC = TabBarController.init()
            window?.rootViewController = rootVC
        }else {
            userDefault.setValue(["tag":"1","version":version], forKey: "GuideHistory")
            let vc = GuideVC()
            window?.rootViewController = vc
        }
        
        self.window?.makeKeyAndVisible();
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

