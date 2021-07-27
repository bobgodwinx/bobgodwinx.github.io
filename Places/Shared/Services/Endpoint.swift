//
//  Endpoint.swift
//  Places
//
//  Created by Bob Godwin Obi on 27.01.21.
//

import Foundation

enum Endpoint:String, CustomStringConvertible, RawRepresentable {
    static let baseURLString = "https://bobgodwinx.github.io/PlacesAssets/Assets"
    case location
    case tips
    
    var description: String {
        switch self {
        case .location: return "location"
        case .tips: return "tips"
        }
    }
    
    var rawValue: String {
        switch self {
        case .location: return "\(Self.baseURLString)/Json/locations.json"
        case .tips: return "\(Self.baseURLString)/Json/tips.json"
        }
    }
}
