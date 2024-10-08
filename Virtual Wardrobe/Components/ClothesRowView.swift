//
//  ClothesRowView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 08/10/24.
//

import SwiftUI

struct ClothesRowView: View {
    let categoryName: String
    let subCategories: [String]
    @State var selectedSubCategory: String
    
    
    var body: some View {
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
                
                Circle()
                    .fill(Color.main)
                    .frame(width: 25)
                    .overlay {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                    }
            }
            HStack{
                ScrollView(.horizontal){
                    
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ClothesRowView(categoryName: "Top", subCategories: ["T-Shirts","T-Shorts"], selectedSubCategory: "T-Shirts")
        .padding()
}
