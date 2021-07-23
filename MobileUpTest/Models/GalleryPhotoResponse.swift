//
//  GalleryPhoto.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 23.07.2021.
//

import Foundation

struct PhotoResponse: Codable {
    let response: PhotoItems
}

struct PhotoItems: Codable {
    let items: [PhotoSizes]
}

struct PhotoSizes: Codable {
    let sizes: [PhotoInfo]
}

struct PhotoInfo: Codable {
    let type: String
    let url: String
}
