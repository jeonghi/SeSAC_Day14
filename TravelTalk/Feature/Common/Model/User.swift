//
//  User.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import Foundation

enum User: String, Codable {
    case hue = "Hue"
    case jack = "Jack"
    case bran = "Bran"
    case den = "Den"
    case user
    case other_friend = "내옆자리의앞자리에개발잘하는친구"
    case simsim = "심심이"
    
    var profileImage: String {
        switch self {
        default: return rawValue
        }
    }
}
