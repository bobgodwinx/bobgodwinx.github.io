//
//  LocationImage.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//


import Foundation
import SwiftUI

struct LocationImage: Hashable {
    let id: UUID
    let image: Image
    
    init(_ image: Image) {
        self.id = UUID()
        self.image = image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
