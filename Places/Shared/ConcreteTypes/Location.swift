//
//  Location.swift
//  Places
//
//  Created by Bob Godwin Obi on 27.01.21.
//

import Foundation

struct Location: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let country: String
    let description: String
    let more: String
    let latitude: Double
    let longitude: Double
    let heroPicture: String
    let advisory: String
    let pictures: [String]
    let images: [String]
    
    static let example = Location(id: 1,
                           name: "Great Smokey Mountain",
                           country: "United States",
                           description: "A great place to visit",
                           more: "More text here",
                           latitude: 35.6532,
                           longitude: -83.5070, heroPicture: "smokies",
                           advisory: "We accept no liability for any visitors eaten alive by midges",
                           pictures: ["photo2", "photo3", "photo4"],
                           images: ["01_01.jpg", "01_02.jpg", "01_03.jpg", "01_04.jpg", "01_05.jpg"])
}


extension Location {
    static func make(with error: APIError) -> Location {
        Location(id: 1,
                 name: "App Error!",
                 country: "",
                 description: error.description,
                 more: "_",
                 latitude: 35.6532,
                 longitude: -83.5070, heroPicture: "error",
                 advisory: "Error while loading location",
                 pictures: [],
                 images: [])
    }
}
