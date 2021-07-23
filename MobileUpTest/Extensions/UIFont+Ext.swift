//
//  UIFont+Ext.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import UIKit

enum FontSize {
    case Small
    case Medium
    case Big
}

extension UIFont {
    
    static func setFont(size: FontSize, weight: Weight = .regular) -> UIFont {
        let deviceType = UIDevice.current.deviceType

        switch deviceType {
        case .iPhone4_4S:
            if size == .Small { return UIFont.systemFont(ofSize: 6, weight: weight) }
            if size == .Medium { return UIFont.systemFont(ofSize: 12, weight: weight) }
            if size == .Big { return UIFont.systemFont(ofSize: 42, weight: weight) }
        case .iPhones_5_5s_5c_SE:
            if size == .Small { return UIFont.systemFont(ofSize: 9, weight: weight) }
            if size == .Medium { return UIFont.systemFont(ofSize: 15, weight: weight) }
            if size == .Big { return UIFont.systemFont(ofSize: 45, weight: weight) }
        case .iPhones_SE2_6_6s_7_8:
            if size == .Small { return UIFont.systemFont(ofSize: 10, weight: weight) }
            if size == .Medium { return UIFont.systemFont(ofSize: 16, weight: weight) }
            if size == .Big { return UIFont.systemFont(ofSize: 46, weight: weight) }
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            if size == .Small { return UIFont.systemFont(ofSize: 12, weight: weight) }
            if size == .Medium { return UIFont.systemFont(ofSize: 18, weight: weight) }
            if size == .Big { return UIFont.systemFont(ofSize: 48, weight: weight) }
        case .iPhoneX:
            if size == .Small { return UIFont.systemFont(ofSize: 12, weight: weight) }
            if size == .Medium { return UIFont.systemFont(ofSize: 18, weight: weight) }
            if size == .Big { return UIFont.systemFont(ofSize: 48, weight: weight) }
        default:
            if size == .Small { return UIFont.systemFont(ofSize: 12, weight: weight) }
            if size == .Medium { return UIFont.systemFont(ofSize: 18, weight: weight) }
            if size == .Big { return UIFont.systemFont(ofSize: 48, weight: weight) }
        }
        return UIFont.systemFont(ofSize: 18, weight: weight)
    }
    
}
