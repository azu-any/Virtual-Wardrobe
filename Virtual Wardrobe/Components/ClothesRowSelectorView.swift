//
//  ClothesRowView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 08/10/24.
//

import SwiftUI
import SwiftData

struct ClothesRowSelectorView: View {
    let categoryName: String
    let subCategories: [String]
    @State var selectedSubCategory: String
    var action: () -> Void
    @Environment(\.modelContext) var context
    @Query var clothes: [Clothe]
    @Query var outfits: [Outfit]
    @Binding var myOutfit: Outfit
    
    var isEmpty: Bool{
        var count = 0
        
        for clothe in clothes{
            if subCategories.contains(clothe.type.rawValue){
                count += 1
            }
        }
        
        if count == 0{
            return true
        }
        return false
    }

    var body: some View {
        NavigationStack{
            if !isEmpty{
                VStack{
                    HStack{
                        Text(categoryName)
                            .font(.title)
                        
                        Picker("Picker", selection: $selectedSubCategory) {
                            ForEach(subCategories, id: \.self) {
                                Text($0)
                            }
                        }
                        Spacer()
                        
                        Button {
                            action()
                        } label: {
                            Image(systemName: "chevron.right")
                            .foregroundStyle(.main)
                        }

                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(clothes){ clothe in
                                if selectedSubCategory == clothe.type.rawValue{
                                    Button {
                                        
                                        if myOutfit.hasClothe(clothe) {
                                            myOutfit.removeClothe(clothe)
                                        } else {
                                            myOutfit.addClothe(clothe)
                                        }
                                        
                                    } label: {
                                        if myOutfit.hasClothe(clothe) {
                                            ClothesCardView(clothe: clothe)
                                                .opacity(0.5)
                                                .overlay(Image(systemName: "checkmark.circle.fill"),
                                                         alignment: .bottomTrailing
                                                         )
                                        } else {
                                            ClothesCardView(clothe: clothe)
                                        }
                                        
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                    .padding(.leading)
                    
                }
            }
        }
        
    }
}

/*
 #Preview(traits: .sizeThatFitsLayout) {
 ZStack{
 Color.gray.opacity(0.1).ignoresSafeArea()
 ClothesRowView(categoryName: "Top", subCategories: ["T-Shirts","T-Shorts"], selectedSubCategory: "T-Shirts", action: {})
 }
 }
 */
