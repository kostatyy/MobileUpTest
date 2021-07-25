//
//  GalleryViewModel.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

class GalleryViewModel {
    
    var photo_urls = [String]()
    var photos = [Photo]()
    
    // Get Photos Urls
    func getPhotos(completion: @escaping ()->()) {
        photos = PhotosCoreDataManager.shared.fetchPhotos()

        if photos.count == 0 { // If There Is No CoreData For Photo Yet
            VKManager.shared.getPhotos { (urls) in
                self.photo_urls = urls
                completion()
            }
        } else { completion() }
        
    }
    
    // Logging out from VK account
    func logoutFromVK(completion: @escaping ()->()) {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "expirationDate")
        completion()
    }
    
}
