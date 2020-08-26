//
//  String+Extension.swift
//  DemoTab
//
//  Created by CitySpidey on 6/27/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import Foundation
extension String{
    func calcAge() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let yourDate = formatter.date(from: self)
        let calendar : NSCalendar = NSCalendar(calendarIdentifier: .indian)!
        let now = Date()
        return "\(calendar.components(.year, from: yourDate!, to: now, options:[]).year!)"
    }
}
