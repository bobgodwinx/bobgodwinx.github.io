//
//  LocationImage.swift
//  Places
//
//  Created by Bob Godwin Obi on 28.01.21.
//


import Foundation
import SwiftUI

struct LocationImage: Identifiable {
    let id: UUID
    let image: Image
    init(_ image: Image) {
        self.id = UUID()
        self.image = image
    }
}
