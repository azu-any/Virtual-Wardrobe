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
class Outfit {
    @Attribute(.unique) var id: UUID = UUID()
    var clothes: [Clothe]
    var createdDate: Date
    var selectedEmotion: Int?
    
    init(clothes: [Clothe], createdDate: Date = Date()) {
        self.clothes = clothes
        self.createdDate = createdDate
    }


    // Function to add a Clothe to the outfit
    func addClothe(_ clothe: Clothe) {
        // Check if the clothe type already exists in the outfit
        if let index = self.clothes.firstIndex(where: { $0.type == clothe.type }) {
            // Replace existing clothe
            self.clothes[index] = clothe
        } else {
            // Add new clothe
            self.clothes.append(clothe)
        }
    }
    
    // Function to check if a Clothe of a specific type exists
    func hasClothe(_ clothe: Clothe) -> Bool {
        return clothes.contains(where: { $0 == clothe })
    }
    
    func containsOutfitAdded(on date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        // Compare with the createdDate of this outfit
        let outfitComponents = calendar.dateComponents([.year, .month, .day], from: createdDate)
        return components == outfitComponents
    }
}

