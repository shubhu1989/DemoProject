//
//  LoginViewController.swift
//  DemoTab
//
//  Created by CitySpidey on 7/20/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit
import SVProgressHUD
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import AppCenter
import AppCenterCrashes

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cusRoundView: UIView!
    
    @IBOutlet weak var txtEmailId: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MSAppCenter.start("c35f3588-6e68-40bb-9f7d-38cc4fe947f8", withServices:[
          MSCrashes.self
        ])
        
        print("Login Page")
        
        btnLogin.layer.cornerRadius = 10.0
        btnLogin.clipsToBounds = true
        
        btnLogin.layer.shadowColor = UIColor.black.cgColor
        btnLogin.layer.shadowOffset = .zero
        btnLogin.layer.shadowRadius = 5
        btnLogin.layer.shadowOpacity = 1.0
        btnLogin.layer.masksToBounds = false
        
        //btnLogin.layer.shadowPath = UIBezierPath(rect: btnLogin.bounds).cgPath
        //btnLogin.layer.shouldRasterize = true
        
        btnSignUp.layer.cornerRadius = 10.0
        btnSignUp.clipsToBounds = true
        
        cusRoundView.clipsToBounds = true
        cusRoundView.layer.cornerRadius = 50
        cusRoundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.hideKeyBoardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtPassword.text = ""
        txtEmailId.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func textFieldDidChange(_ textfield: UITextField) {
        if textfield == txtEmailId {
            if (txtEmailId.text?.isEmaildValid)!{
                txtEmailId.errorMessage = ""
            }
            else{
                txtEmailId.errorMessage = "Invalid email"
            }
        }
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        IQKeyboardManager.shared.resignFirstResponder()
        
        if (((txtEmailId.text?.isEmaildValid) != nil) && txtPassword.text?.count != 0){
            SVProgressHUD.show(withStatus: "Please Wait...")
            
            let modellogin = LoginModel(login: txtEmailId.text!, password: txtPassword.text!)
            
            APIManager.sharedInstance.callingLoginApi(login:modellogin){ (result) in
                switch result{
                case .success(let json) :
                    //print(json)
                    let name = (json as! ResponseModel).name
                    let email = (json as! ResponseModel).email
                    let userToken = (json as! ResponseModel).userToken
                    
                    let dict:[String:String] = ["name":name,"email":email]
                    UserRecord.userData.saveData(dict: dict)
                    
                    TokenService.tokenService.saveToken(token: userToken)
                    
                    let dashBoardVC = DashboardViewController.shareInstance()
                    //dashBoardVC.strName = name + "\n" + email
                    dashBoardVC.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(dashBoardVC, animated: true)
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
                SVProgressHUD.dismiss()
            }
        }
        else{
            self.popUpAlert(title: "Alert", message:"Please enter the details!")
        }
    }
    
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        let registerVC = RegisterViewController.shareInstance()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginViewController{
    static func shareInstance() -> LoginViewController{
        return self.instantiateFromStoryboard("Login")
    }
}
