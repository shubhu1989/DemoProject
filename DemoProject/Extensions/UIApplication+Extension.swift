//
//  UIApplication+Extension.swift
//  DemoTab
//
//  Created by CitySpidey on 7/21/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation
import  UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
