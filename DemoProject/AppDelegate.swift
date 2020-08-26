//
//  AppDelegate.swift
//  DemoTab
//
//  Created by CitySpidey on 6/25/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        // MARK: IQKeyboardManager
        IQKeyboardManager.shared.enable = true

        MSAppCenter.start("c35f3588-6e68-40bb-9f7d-38cc4fe947f8", withServices:[
          MSAnalytics.self,
          MSCrashes.self
        ])
        
        // MARK: CheckFor Login
        let vc:UIViewController?
        if TokenService.tokenService.checkForLogin(){
            vc = DashboardViewController.shareInstance()
        }
        else{
            vc = LoginViewController.shareInstance()
        }
        let navVC = UINavigationController(rootViewController: vc!)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

