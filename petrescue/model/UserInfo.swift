//
//  UserInfo.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-24.
//

import Foundation

struct UserInfo: Codable {
    let submitterName: String
    let submitterPhone: String
    let submitterEmail: String
    let agreeToTerms: Bool
    let latlong: LatLong
}
