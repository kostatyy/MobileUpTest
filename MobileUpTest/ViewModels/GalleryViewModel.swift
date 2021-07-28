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
    
    //MARK: - Get Photos Urls
    func getPhotos(completion: @escaping (String?)->()) {
        photos = PhotosCoreDataManager.shared.fetchPhotos()

        if photos.count == 0 { // If There Is No CoreData For Photo Yet
            VKManager.shared.getPhotos { (result) in
                switch result {
                    case .success(let photos):
                        self.photos = photos
                        completion(nil)
                    case .failure(let error):
                        completion(error.localizedDescription)
                    }
            }
        } else { completion(nil) }
        
    }
    
    //MARK: - Logging out from VK account
    func logoutFromVK(completion: @escaping ()->()) {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "expirationDate")
        completion()
    }
    
}
