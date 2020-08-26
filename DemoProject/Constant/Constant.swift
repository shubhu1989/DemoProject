//
//  Constant.swift
//  DemoTab
//
//  Created by CitySpidey on 7/14/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation

let app_id = "0025A229-E0A7-1C0E-FFB7-02BD341C9400"
let rest_key = "A0A87BE7-669E-424F-97F0-01289184D639"
let base_url = "https://api.backendless.com/\(app_id)/\(rest_key)/users/"
let register_url = "\(base_url)register"
let login_url = "\(base_url)login"
let logout_url = "\(base_url)logout"

struct TokenKey {
    static let userLogin = "USER_LOGIN_KEY"
}
