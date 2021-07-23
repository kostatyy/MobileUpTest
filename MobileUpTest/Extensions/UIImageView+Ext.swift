//
//  UIImageView+Ext.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import UIKit

private var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadUserImage(urlString: String) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
        } else {
            let url = URL(string: urlString)!
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    return
                }

                DispatchQueue.main.async() {
                    guard let image = UIImage(data: data) else {return}
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }.resume()
        }
    }
    
}
