//
//  TokenService.swift
//  DemoTab
//
//  Created by CitySpidey on 7/20/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation

class TokenService{
    static let tokenService = TokenService()
    let userDefault = UserDefaults.standard
    
    func saveToken(token:String){
        userDefault.set(token, forKey: TokenKey.userLogin)
    }
    
    func getToken() -> String{
        if let token = userDefault.object(forKey: TokenKey.userLogin) as? String{
            return token
        }
        else{
            return ""
        }
    }
        
    func checkForLogin() -> Bool{
        if getToken() == ""{
            return false
        }else{
            return true
        }
    }
    
    func removeToken(){
        userDefault.removeObject(forKey: TokenKey.userLogin)
    }
}

class UserRecord{
    static let userData = UserRecord()
    
    let userDefault = UserDefaults.standard
    
    func saveData(dict:[String:String]){
        userDefault.set(dict, forKey:"UserRecord")
    }
    
    func getData() -> NSDictionary{
        return (userDefault.object(forKey: "UserRecord") as? NSDictionary)!
    }
}
