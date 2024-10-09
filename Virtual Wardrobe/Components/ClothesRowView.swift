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
    var action: () -> Void
    
    
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
                    ForEach(1...8, id:\.self){ _ in
                        ClothesCardView(imageName: "mockup_shirt", isSelected: false)
                            .padding(1)
                    }
                }
            }
            .padding(.leading)
            
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ZStack{
        Color.gray.opacity(0.1).ignoresSafeArea()
        ClothesRowView(categoryName: "Top", subCategories: ["T-Shirts","T-Shorts"], selectedSubCategory: "T-Shirts", action: {})
    }
}
