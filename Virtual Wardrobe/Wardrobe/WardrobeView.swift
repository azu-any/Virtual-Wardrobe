//
//  WardrobeView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI

struct WardrobeView: View {
    
    @State private var showAddClothesView = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    
                    
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
