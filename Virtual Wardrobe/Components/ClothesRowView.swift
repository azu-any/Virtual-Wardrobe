//
//  ClothesRowView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 08/10/24.
//

import SwiftUI
import SwiftData

struct ClothesRowView: View {
    let categoryName: String
    let subCategories: [String]
    @State var selectedSubCategory: String
    var action: () -> Void
    
    @Query var clothes: [Clothe]
    
    var isEmpty: Bool{
        var count = 0
        
        for clothe in clothes{
            if subCategories.contains(clothe.type){
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
                            Circle()
                                .fill(Color.main)
                                .frame(width: 25)
                                .overlay {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                }
                      
                        }

                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(clothes){ clothe in
                                if selectedSubCategory == clothe.type{
                                    NavigationLink {
                                        ClotheDetailView(clothe: clothe)
                                    } label: {
                                        ClothesCardView(clothe: clothe)
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
