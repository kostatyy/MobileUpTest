//
//  VKManager.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import UIKit
import Alamofire

class VKManager {
    
    static let shared = VKManager()
    
    private let base_url = "https://oauth.vk.com/"
    private let client_id = 7909445
    private let client_secret = "jI7aLjzqJRPR4diSYjjj"
    private let redirect_uri = "http://mobileUp.com/verify"
    private let scopes = "photos"
    
    // Constants For Photos
    private let vkApiMethod = "https://api.vk.com/method"
    private let ownerId = -128666765
    private let albumId = 266276915
    
    
    var isSignedIn: Bool {
        guard let _ = accessToken, let expirationDate = tokenExpirationDate else { // If there is no access token and exp. Date
            return false
        }
        
        let curDate = Date()
        return expirationDate >= curDate // Checking whether the token has expired
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
    public func exchangeCodeForToken(code: String, completion: @escaping ((String?) -> Void)) {
        let authAPI = "\(base_url)access_token?client_id=\(client_id)&client_secret=\(client_secret)&redirect_uri=\(redirect_uri)&code=\(code)"
        
        AF.request(authAPI)
            .validate()
            .responseDecodable(of: VKAuthResponse.self) { (response) in
                switch response.result {
                case .success(let result):
                    self.cacheToken(result: result)
                    completion(nil)
                case .failure(let error):
                    completion(error.localizedDescription)
                }
            }
    }
    
    /* Saving user's token and exp. Date */
    private func cacheToken(result: VKAuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    
    // Get Photos Urls
    public func getPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let access_token = accessToken else {return}
        let photosAPI = "\(vkApiMethod)/photos.get?owner_id=\(ownerId)&album_id=\(albumId)&access_token=\(access_token)&v=5.77"
        var photos_array = [PhotoItem]()
        AF.request(photosAPI)
            .validate()
            .responseDecodable(of: PhotoResponse.self) { (response) in
                switch response.result {
                case .success(let resp):
                    resp.response.items.forEach { item in
                        let photo_item = PhotoItem(url: nil, date: item.date)
                        photos_array.append(photo_item)
                    }
                    
                    let filteredPhotos = resp.response.items.flatMap { // Filtering Photos By Type
                        $0.sizes.filter { size in
                            return size.type == "z"
                        }
                    }
                    
                    var i = 0
                    
                    filteredPhotos.forEach { // Getting Urls Of Images
                        photos_array[i].url = $0.url
                        
                        guard PhotosCoreDataManager.shared.savePhoto(photoItem: photos_array[i]) != nil else { // Saving Photo To CoreData
                            return
                        }
                        i += 1
                    }
                    
                    let photos = PhotosCoreDataManager.shared.fetchPhotos()
                    completion(.success(photos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
