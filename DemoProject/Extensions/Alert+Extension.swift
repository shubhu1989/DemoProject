//
//  Alert+Extension.swift
//  DemoTab
//
//  Created by CitySpidey on 6/27/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIAlertController
extension UIAlertController {
    static func alert(title:String, message:String, viewController:UIViewController){
        let myalert = UIAlertController(title: title, message: message,  preferredStyle:.alert)

        myalert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in
            print("Selected")
        }))
        
        myalert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action:UIAlertAction!) in
            print("Cancel")
        }))
        
        viewController.present(myalert, animated: true, completion: nil)
    }
}

extension UIViewController{
    func popUpAlert(title:String, message:String, action:((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default, handler: action)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func popUpAlertWithCompletion(title:String, message:String, action:((UIAlertAction) -> Void)? = nil, completion:@escaping((Bool) -> Void)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default, handler: { action in
            completion(true)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyBoardWhenTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    class func instantiateFromStoryboard(_ name:String) -> Self{
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name:String) -> T{
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! T
        return controller
    }
}
