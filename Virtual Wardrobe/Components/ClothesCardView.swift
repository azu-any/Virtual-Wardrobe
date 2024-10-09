//
//  ClothesCardView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 08/10/24.
//

import SwiftUI

struct ClothesCardView: View {
    
    let imageName: String
    let isSelected: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 23)
                .fill(isSelected ? Color.main : .white)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 60)
        }
        .frame(width: 90, height: 90)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ClothesCardView(imageName: "mockup_shirt", isSelected: false)
        .shadow(radius: 2)
        .padding()
    
    ClothesCardView(imageName: "mockup_shirt", isSelected: true)
        .shadow(radius: 2)
        .padding()
}
