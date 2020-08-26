//
//  APIManager.swift
//  DemoTab
//
//  Created by CitySpidey on 7/16/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation
import Alamofire

//*-----------------------------------*//
// MARK: ENUM USING IN LOGIN API
enum APIErrors : Error{
    case custom(message:String)
}

typealias Handler = (Swift.Result<Any? ,APIErrors>) -> Void
//*-----------------------------------*//

class APIManager{
    static let sharedInstance = APIManager()
    
    // MARK: RegisterAPI
    func callingResgisterApi(register:RegisterModel, completion:@escaping((Bool, String) -> ())){
        let headers:HTTPHeaders = [
        .contentType("application/json")
        ]
        
        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{
            response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200 {
                        completion(true, "User Register Successfully")
                    }
                    else{
                        completion(false, "Please Try Again")
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(false,"Please Try Again")
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false,"Please Try Again")
            }
        }
    }
    
    // MARK: LOGINAPI
    func callingLoginApi(login:LoginModel, completionHandler: @escaping Handler){
        let headers:HTTPHeaders = [
        .contentType("application/json")
        ]
        
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else{
                        completionHandler(.failure(.custom(message: "Please Check your Network Connection")))
                    }
                }catch{
                    completionHandler(.failure(.custom(message: "Please Try Again")))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.custom(message: "Please Try Again")))
            }
        }
    }
    
    // MARK: LOGOUTAPI
    func callingLogoutAPI(completion:@escaping((Bool) -> ())){
        let headers:HTTPHeaders = [
            "user-token":"\(TokenService.tokenService.getToken())"
        ]
        AF.request(logout_url, method: .get, headers:headers).response{
            reseponse in
            switch reseponse.result{
            case .success(_):
                TokenService.tokenService.removeToken()
                //vc.navigationController?.popToRootViewController(animated: true)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
