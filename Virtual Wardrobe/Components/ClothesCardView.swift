//
//  ClothesCardView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 08/10/24.
//

import SwiftUI

struct ClothesCardView: View {
    
    let clothe: Clothe
    var isSelected: Bool = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 23)
                .fill(isSelected ? Color.main : .white)
            
            Image(uiImage: UIImage(data: clothe.image ?? Data())!)
                .resizable()
                .scaledToFit()
                .frame(height: 60)
        }
        .frame(width: 90, height: 90)
        .padding(2)
        .shadow(radius: 2)
    }
}


//#Preview(traits: .sizeThatFitsLayout) {
//    ClothesCardView(clothe: Clothe(image: Data(), redAmount: 0, greenAmount: 0, blueAmount: 0, type: "jeans"), isSelected: false)
//        .shadow(radius: 2)
//        .padding()
//    
//    ClothesCardView(clothe: Clothe(image: Data(), redAmount: 0, greenAmount: 0, blueAmount: 0, type: "jeans"), isSelected: true)
//        .shadow(radius: 2)
//        .padding()
//}

