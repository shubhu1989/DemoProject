//
//  RegisterViewController.swift
//  DemoTab
//
//  Created by CitySpidey on 7/16/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit
import SVProgressHUD
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnSubmitSignUp: UIButton!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmailId: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnSubmitSignUp.layer.cornerRadius = 10.0
        btnSubmitSignUp.clipsToBounds = true
        
        btnSubmitSignUp.layer.shadowColor = UIColor.black.cgColor
        btnSubmitSignUp.layer.shadowOffset = CGSize(width: 0, height: 0)
        btnSubmitSignUp.layer.shadowRadius = 5
        btnSubmitSignUp.layer.shadowOpacity = 1.0
        btnSubmitSignUp.layer.masksToBounds = false
        
        self.hideKeyBoardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtPassword.text = ""
        txtEmailId.text = ""
        txtName.text = ""
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func textFieldDidChange(_ textfield: UITextField) {
        if textfield == txtName {
            if (txtName.text?.isNameValid)!{
                txtName.errorMessage = ""
            }
            else{
                txtName.errorMessage = "Invalid Name"
            }
        }
        else if textfield == txtEmailId {
            if (txtEmailId.text?.isEmaildValid)!{
                txtEmailId.errorMessage = ""
            }
            else{
                txtEmailId.errorMessage = "Invalid email"
            }
        }
        else if textfield == txtPassword {
            if (txtPassword.text?.isPasswordValid)!{
                txtPassword.errorMessage = ""
            }
            else{
                txtPassword.errorMessage = "Enter one special character atleast"
            }
        }
    }
    
    
    //MARK: - Register
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        IQKeyboardManager.shared.resignFirstResponder()
        
        if ((txtName.text?.isNameValid)! && ((txtEmailId.text?.isEmaildValid) != nil) && ((txtPassword.text?.isPasswordValid) != nil)){
            SVProgressHUD.show(withStatus: "Please Wait...")
            
            let register = RegisterModel(name: txtName.text!, email: txtEmailId.text!, password: txtPassword.text!)
            
            APIManager.sharedInstance.callingResgisterApi(register: register) { (isSuccess, str) in
                if isSuccess{
                    self.popUpAlertWithCompletion(title: "Alert", message:str, completion: {_ in
                        self.navigationController?.popViewController(animated: true)
                    })
//                    self.txtPassword.text = ""
//                    self.txtEmailId.text = ""
//                    self.txtName.text = ""
                }
                else{
                    self.popUpAlert(title: "Alert", message:str)
                }
                SVProgressHUD.dismiss()
            }
        }
        else{
            self.popUpAlert(title: "Alert", message:"Please enter the details!")
        }
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension String{
    var isPasswordValid:Bool{
        let password = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return password.evaluate(with: self)
    }
    
    var isEmaildValid:Bool{
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        return emailTest.evaluate(with: self)
    }
    
    var isNameValid:Bool{
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9]{3,100}")
        return nameTest.evaluate(with: self)
    }
}

extension RegisterViewController{
    static func shareInstance() -> RegisterViewController{
        return self.instantiateFromStoryboard("Register")
    }
}
