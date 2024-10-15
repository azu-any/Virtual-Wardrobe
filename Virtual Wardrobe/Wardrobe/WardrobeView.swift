//
//  WardrobeView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI
import SwiftData

struct WardrobeView: View {
    @Environment(\.modelContext) private var context
    @State private var showAddClothesView = false
    
    @Query var clothes: [Clothe]

    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 30){
                    
                    ClothesRowView(categoryName: "Tops", subCategories: ["t-shirts", "jackets", "coats", "sweaters", "hoodies", "shirts", "blouses"], selectedSubCategory: "t-shirts", action: {})
                    
                    ClothesRowView(categoryName: "Bottom", subCategories: ["jeans", "shorts", "skirts", "leggings"], selectedSubCategory: "jeans", action: {})
                    
                    ClothesRowView(categoryName: "Footwear", subCategories: ["sneakers"], selectedSubCategory: "sneakers", action: {})
                    
                    ClothesRowView(categoryName: "Accessories", subCategories: ["necklace", "earrings", "bracelet", "watch", "glasses"], selectedSubCategory: "necklace", action: {})
                    
                    
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddClothesView.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                        }

                    }
                })
                .padding(.top)
                .navigationTitle("Wardrobe")
            }
        }
        .sheet(isPresented: $showAddClothesView, content: {AddClothesView(showAddClothesView: $showAddClothesView)})
    }
        
}

#Preview {
    WardrobeView()
}

extension WardrobeView{
    private var emptyWardrobeView: some View{
        VStack{
            Button {
                
            } label: {
                ZStack{
                    Circle()
                        .fill(Color.main)
                        .frame(width: 124, height: 124)
                    
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .font(.system(size: 70))
                    
                }
            }
            
            Text("Your wardrobe is empty.\n Let's fill it!")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.top)
        }
    }
}
