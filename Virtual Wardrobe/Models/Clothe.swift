//
//  Clothe.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 14/10/24.
//

import Foundation
import SwiftData
import SwiftUI


@Model
class Clothe {
    @Attribute(.unique) var id: UUID = UUID()
    @Attribute(.externalStorage) var image: Data?
    var hexColor: String
    var type: String
    var timesUsed: Int = 0
    
    // Relationship to Outfit
    @Relationship(deleteRule: .nullify, inverse: \Outfit.clothes)var outfits: [Outfit] = []// Inverse relationship
    
    init(image: Data? = nil, hexColor: String, type: String) {
        self.image = image
        self.hexColor = hexColor
        self.type = type
    }
}



