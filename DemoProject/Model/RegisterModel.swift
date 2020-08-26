//
//  RegisterModel.swift
//  DemoTab
//
//  Created by CitySpidey on 7/16/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation
import UIKit

struct RegisterModel:Encodable{
    let name:String
    let email:String
    let password:String
}

// MARK: - ResponseModel
struct ResponseModel:Codable{
    let welcomeClass, blUserLocale: String
    let created: Int
    let email: String
    let lastLogin: Int
    let name, objectID, ownerID, socialAccount: String
    //let updated: JSONNull?
    let userToken, userStatus: String

    enum CodingKeys: String, CodingKey {
        case welcomeClass = "___class"
        case blUserLocale, created, email, lastLogin, name
        case objectID = "objectId"
        case ownerID = "ownerId"
        case socialAccount
        case userToken = "user-token"
        case userStatus
    }
}
