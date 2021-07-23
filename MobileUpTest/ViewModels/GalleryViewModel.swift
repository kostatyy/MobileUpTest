//
//  GalleryViewModel.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

class GalleryViewModel {
    
    var photo_urls = [String]()
    
    // Get Photos Urls
    func getPhotos(completion: @escaping ()->()) {
        VKManager.shared.getPhotos { (urls) in
            self.photo_urls = urls
            completion()
        }
    }
    
    // Logging out from VK account
    func logoutFromVK(completion: @escaping ()->()) {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "expirationDate")
        completion()
    }
    
}
