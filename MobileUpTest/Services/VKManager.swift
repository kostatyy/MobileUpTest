//
//  VKManager.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import UIKit

class VKManager {
    
    static let shared = VKManager()
    
    private let base_url = "https://oauth.vk.com/"
    private let client_id = 7909445
    private let client_secret = "jI7aLjzqJRPR4diSYjjj"
    private let redirect_uri = "http://mobileUp.com/verify"
    private let scopes = "photos"
    
    var isSignedIn: Bool {
        guard let _ = accessToken, let expirationDate = tokenExpirationDate else { // If there is no access token and exp. Date
            return false
        }
        
        let curDate = Date()
        return curDate >= expirationDate // Checking whether the token has expired
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    /* VK SignIn URL Link */
    public var signInUrl: URL? {
        let string = "\(base_url)authorize?client_id=\(client_id)&display=mobile&redirect_uri=\(redirect_uri)&scope=\(scopes)&response_type=code"
        return URL(string: string)
    }
    
    /* Exchanging authorization code for access token */
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        let authAPI = "\(base_url)access_token?client_id=\(client_id)&client_secret=\(client_secret)&redirect_uri=\(redirect_uri)&code=\(code)"
        let url = URL(string: authAPI)!
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {(data, resp, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(VKAuthResponse.self, from: data)
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    /* Saving user's token and exp. Date */
    private func cacheToken(result: VKAuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
