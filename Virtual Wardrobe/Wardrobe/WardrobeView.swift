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
    @State private var showingSheet = false
    
    @Query var clothes: [Clothe]
    
    
    var body: some View {
        NavigationStack{
            VStack{
                if clothes.isEmpty{
                    emptyWardrobeView
                }else{
                    ScrollView {
                        
                        VStack(spacing: 30){
                            
                            ClothesRowView(categoryName: "Tops", subCategories: ["T-Shirts", "Jackets", "Coats", "Sweaters", "Hoodies", "Shirts", "Blouses"], selectedSubCategory: "T-Shirts", action: {})
                            
                            ClothesRowView(categoryName: "Bottom", subCategories: ["Jeans", "Shorts", "Skirts", "Leggings"], selectedSubCategory: "Jeans", action: {})
                            
                            ClothesRowView(categoryName: "Footwear", subCategories: ["Sneakers"], selectedSubCategory: "Sneakers", action: {})
                            
                            ClothesRowView(categoryName: "Accessories", subCategories: ["Necklace", "Earrings", "Bracelet", "Watch", "Glasses"], selectedSubCategory: "Necklace", action: {})
                        }
                        
                        
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
                }
            }
            .padding(.top)
            .navigationTitle("Wardrobe")
        }
        .overlay(alignment: .bottom, content: {
            Button(
                action:{
                    showingSheet.toggle()
                }
                
            ) {
                HStack {
                    Text("Style Me")
                        .font(.title2.bold())
                    
                    Image(systemName: "wand.and.sparkles")
                        .renderingMode(.original)
                        .font(.system(size: 30))
                }
                
            }
            .buttonStyle(MainButton())
            .shadow(radius: 20)
            .padding(.bottom, 20)
            .sheet(isPresented: $showingSheet) {
                StyleView(showingSheet: $showingSheet)
                    .presentationDetents([.fraction(CGFloat(0.4))])
            }
        })
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
                showAddClothesView.toggle()
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
