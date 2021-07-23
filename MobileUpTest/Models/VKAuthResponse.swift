//
//  VKAuthResponse.swift
//  MobileUpTest
//
//  Created by Macbook Pro on 22.07.2021.
//

import Foundation

struct VKAuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let user_id: Int
}
