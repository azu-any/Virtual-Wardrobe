//
//  GenerateOutfit.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila Cerón on 17/10/24.
//

import SwiftUI

// Define a structure to represent a clothing item
struct ClothingItem {
    let category: String
    let color: Color
    let image: String // Assuming image is a string (name or path)
}
// Function to determine if two colors match
func colorsMatch(color1: Color, color2: Color) -> Bool {
    // Convert SwiftUI Color to UIColor to access HSL components
    let uiColor1 = UIColor(color1)
    let uiColor2 = UIColor(color2)
    
    // Get the HSL components for both colors
    var hue1: CGFloat = 0
    var saturation1: CGFloat = 0
    var brightness1: CGFloat = 0
    uiColor1.getHue(&hue1, saturation: &saturation1, brightness: &brightness1, alpha: nil)

    var hue2: CGFloat = 0
    var saturation2: CGFloat = 0
    var brightness2: CGFloat = 0
    uiColor2.getHue(&hue2, saturation: &saturation2, brightness: &brightness2, alpha: nil)
    
    // Define thresholds for matching colors
    let hueTolerance: CGFloat = 0.1 // Example tolerance for hue
    let saturationTolerance: CGFloat = 0.1 // Example tolerance for saturation

    // Check if colors are within the defined tolerances
    let hueDifference = abs(hue1 - hue2)
    let saturationDifference = abs(saturation1 - saturation2)

    // Wrap around for hue, since it is circular
    let hueMatches = hueDifference < hueTolerance || hueDifference > (1 - hueTolerance)
    let saturationMatches = saturationDifference < saturationTolerance

    return hueMatches && saturationMatches
}


// Function to generate combinations of clothes
func generateOutfitCombinations(from clothes: [ClothingItem]) -> [[ClothingItem]] {
    // Categorize clothes by type
    var categorizedClothes: [String: [ClothingItem]] = [:]

    for item in clothes {
        categorizedClothes[item.category, default: []].append(item)
    }
    
    var combinations: [[ClothingItem]] = []
    
    // Generate combinations
    if let tops = categorizedClothes["top"],
       let bottoms = categorizedClothes["bottom"],
       let footwears = categorizedClothes["footwear"],
       let accessories = categorizedClothes["accessories"] {
        
        for top in tops {
            for bottom in bottoms {
                if colorsMatch(color1: top.color, color2: bottom.color) {
                    for footwear in footwears {
                        if colorsMatch(color1: top.color, color2: footwear.color) {
                            for accessory in accessories {
                                if colorsMatch(color1: top.color, color2: accessory.color) {
                                    combinations.append([top, bottom, footwear, accessory])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    return combinations
}

// Sample dataset of clothing items
let clothesDataset: [ClothingItem] = [
    ClothingItem(category: "top", color: .red, image: "top_red"),
    ClothingItem(category: "top", color: .blue, image: "top_blue"),
    ClothingItem(category: "bottom", color: .blue, image: "bottom_blue"),
    ClothingItem(category: "bottom", color: .green, image: "bottom_green"),
    ClothingItem(category: "footwear", color: .red, image: "footwear_red"),
    ClothingItem(category: "footwear", color: .yellow, image: "footwear_yellow"),
    ClothingItem(category: "accessories", color: .blue, image: "accessory_blue"),
    ClothingItem(category: "accessories", color: .green, image: "accessory_green")
]

/*/ Generate and print outfit combinations
let outfitCombinations = generateOutfitCombinations(from: clothesDataset)

for combination in outfitCombinations {
    print(combination.map { "\($0.category) - \($0.color)" })
}*/
