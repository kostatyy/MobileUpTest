//
//  Int+Ext.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

extension Int32 {
    
    func convertUnixToTime() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.locale = Locale(identifier: "ru_RU")
        dayTimePeriodFormatter.dateFormat = "d MMMM YYYY"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}
