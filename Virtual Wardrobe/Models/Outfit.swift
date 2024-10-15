//
//  Outfit.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 14/10/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Outfit{
    @Attribute(.unique) var id: UUID = UUID()
    var clothes: [Clothe] = []
    var timestamp: Date
    
    init(clothes: [Clothe], timestamp: Date) {
        self.clothes = clothes
        self.timestamp = timestamp
    }
}
