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
    
    var redAmount: Int
    var greenAmount : Int
    var blueAmount: Int
    
    var type: String
    var timesUsed: Int = 0
    
    init(image: Data, redAmount: Int, greenAmount: Int, blueAmount: Int, type: String) {
        self.image = image
        self.redAmount = redAmount
        self.greenAmount = greenAmount
        self.blueAmount = blueAmount
        self.type = type
    }
}
