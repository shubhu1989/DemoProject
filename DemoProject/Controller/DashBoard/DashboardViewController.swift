//
//  DashboardViewController.swift
//  DemoTab
//
//  Created by CitySpidey on 7/17/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit
import SVProgressHUD

class DashboardViewController: UIViewController {

    var strName:String = ""
    
    @IBOutlet weak var lblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict:NSDictionary = UserRecord.userData.getData()
        //print(dict)
        
        lblName.text = "\(dict["name"]!)" + "\n" + "\(dict["email"]!)"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backItem?.hidesBackButton = true
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIBarButtonItem) {
        SVProgressHUD.show(withStatus: "Please Wait...")
        
        APIManager.sharedInstance.callingLogoutAPI { (isSuccess) in
            if isSuccess{
                let rootVC = UIApplication.shared.windows.first?.rootViewController
                if let topVC = UIApplication.topViewController(){
                    if rootVC?.children.first is DashboardViewController{
                        topVC.navigationController?.pushViewController(LoginViewController.shareInstance(), animated: true)
                    }else{
                        topVC.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            else{
                self.popUpAlert(title: "Alert", message: "Something's went wrong")
            }
            SVProgressHUD.dismiss()
        }
    }
}

extension DashboardViewController{
    static func shareInstance() -> DashboardViewController{
        return self.instantiateFromStoryboard("Dashboard")
    }
}
