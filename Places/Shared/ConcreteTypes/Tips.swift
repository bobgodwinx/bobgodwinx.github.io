//
//  Tips.swift
//  Places
//
//  Created by Bob Godwin Obi on 27.01.21.
//

import Foundation

struct Tip: Codable, Hashable {
    let text: String
    let children: [Tip]?

    var hash: Int {
        var hasher = Hasher()
        hasher.combine(self.text)
        hasher.combine(self.children)
        return hasher.finalize()
    }
}
