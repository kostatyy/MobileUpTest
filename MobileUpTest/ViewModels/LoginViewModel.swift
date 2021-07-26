//
//  LoginViewModel.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import UIKit

class LoginViewModel {
    
    /* VK Auth */
    func requestForCallbackURL(request: URLRequest, completion: @escaping (String?)->()) {
        
        // Exchange code for access token
        let requestURLString = (request.url?.absoluteString)! as String
        
        // Getting code
        let component = URLComponents(string: requestURLString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        VKManager.shared.exchangeCodeForToken(code: code) { (result) in
            completion(result)
        }
    }
    
}
