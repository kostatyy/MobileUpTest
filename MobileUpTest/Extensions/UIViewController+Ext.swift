//
//  UIViewController+Ext.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

extension UIViewController {
    static func instantiate<T>(storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
        return viewController
    }
    
    func customizeNavBarController() {
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target:nil, action:nil)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
