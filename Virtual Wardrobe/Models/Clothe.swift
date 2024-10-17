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
    var type: ClotheType
    var subType: String
    var timesUsed: Int = 0
    
    // Relationship to Outfit
    @Relationship(deleteRule: .nullify, inverse: \Outfit.clothes) var outfits: [Outfit] = []// Inverse relationship
    
    init(image: Data? = nil, hexColor: String, type: ClotheType, subType: String) {
        self.image = image
        self.hexColor = hexColor
        self.type = type
        self.subType = subType
    }
}


extension Clothe {
    enum ClotheType: String, CaseIterable, Codable {
        case top = "Tops"
        case bottom = "Bottoms"
        case footwear = "Footwear"
        case accessories = "Accessories"
        case outerwear = "Outerwear"
        case dresses = "Dresses"
        
        // Retrieve subcategories based on the clothing type
        func subcategories() -> [(String, String)] {
            switch self {
            case .top:
                return Top.allCases.map { ($0.rawValue, $0.category.rawValue) }
            case .bottom:
                return Bottom.allCases.map { ($0.rawValue, $0.category.rawValue) }
            case .footwear:
                return Footwear.allCases.map { ($0.rawValue, $0.category.rawValue) }
            case .accessories:
                return Accessory.allCases.map { ($0.rawValue, $0.category.rawValue) }
            case .outerwear:
                return Outerwear.allCases.map { ($0.rawValue, $0.category.rawValue) }
            case .dresses:
                return Dress.allCases.map { ($0.rawValue, $0.category.rawValue) }
            }
        }
        
        func subCategoriesOnly() -> [String] {
            switch self {
            case .top:
                return Top.allCases.map { $0.rawValue }
            case .bottom:
                return Bottom.allCases.map { $0.rawValue}
            case .footwear:
                return Footwear.allCases.map { $0.rawValue }
            case .accessories:
                return Accessory.allCases.map { $0.rawValue }
            case .outerwear:
                return Outerwear.allCases.map { $0.rawValue }
            case .dresses:
                return Dress.allCases.map { $0.rawValue }
            }
        }
        
        enum Top: String, CaseIterable, Codable {
            case tShirt = "T-Shirts"
            case shirt = "Shirts"
            case sweater = "Sweaters"
            case top = "Tops"
            case blouses = "Blouses"
            case tunics = "Tunics"
            case looseTees = "Loose Tees"
            case bodysuits = "Bodysuits"
            case sportwear = "Sportwear"
            
            var category: ClotheType {
                return .top
            }
        }
        
        enum Bottom: String, CaseIterable, Codable {
            case jeans = "Jeans"
            case shorts = "Shorts"
            case leggings = "Leggings"
            case joggers = "Joggers"
            case skirts = "Skirts"
            case pants = "Pants"
            case pajama = "Pajama"
            case casualSkirts = "Casual Skirts"
            case palazzoPants = "Palazzo Pants"
            case pajamaPants = "Pajama Pants"
            
            var category: ClotheType {
                return .bottom
            }
        }
        
        enum Dress: String, CaseIterable, Codable {
            case maxi = "Maxi"
            case shirtDresses = "Shirt Dresses"
            case cocktailDresses = "Cocktail Dresses"
            case bodycon = "Bodycon"
            case party = "Party Dresses"
            
            var category: ClotheType {
                return .dresses
            }
            
        }
        
        enum Outerwear: String, CaseIterable, Codable {
            case hoodies = "Hoodies"
            case denimJackets = "Denim Jackets"
            case blazers = "Blazers"
            case coats = "Coats"
            case sportsJackets = "Sport Jackets"
            case windbreakers = "Windbreakers"
            case leatherJackets = "Leather Jackets"
            case sweatshirts = "Sweatshirts"
            
            var category: ClotheType {
                return .outerwear
            }
        }
        
        enum Footwear: String, CaseIterable, Codable {
            case sneakers = "Sneakers"
            case sandals = "Sandals"
            case flats = "Flats"
            case loafers = "Loafers"
            case heels = "Heels"
            case ankleBoots = "Ankle Boots"
            case runningShoes = "Running Shoes"
            case slippers = "Slippers"
            
            var category: ClotheType {
                return .footwear
            }
        }
        
        enum Accessory: String, CaseIterable, Codable {
            case necklace = "Necklaces"
            case earrings = "Earrings"
            case handbag = "Handbags"
            case hat = "Hats"
            case cap = "Caps"
            case bracelet = "Bracelets"
            case watch = "Watches"
            case sunglasses = "Sunglasses"
            
            var category: ClotheType {
                return .accessories
            }
        }
    }
}

//case bottom = "Bottoms"
//case footwear = "Footwear"
//case accessories = "Accessories"
//case outerwear = "Outerwear"
//case dresses = "Dresss"
