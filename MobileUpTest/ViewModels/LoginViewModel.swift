//
//  LoginViewModel.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import UIKit

class LoginViewModel {
    
    //MARK: - VK Auth
    func requestForCallbackURL(request: URLRequest, completion: @escaping (String?)->()) {
        
        let requestURLString = (request.url?.absoluteString)! as String
        
        let component = URLComponents(string: requestURLString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        VKManager.shared.exchangeCodeForToken(code: code) { (result) in
            completion(result)
        }
    }
    
}
