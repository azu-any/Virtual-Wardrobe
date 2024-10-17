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
                            
                            // Tops Category
                            ClothesRowView(
                                categoryName: Clothe.ClotheType.top.rawValue,
                                subCategories: Clothe.ClotheType.allCases.map { $0.rawValue },
                                selectedSubCategory: Clothe.ClotheType.Top.tShirt.rawValue,
                                action: {}
                            )
                            
                            // Bottoms Category
                            ClothesRowView(
                                categoryName: Clothe.ClotheType.bottom.rawValue,
                                subCategories: Clothe.ClotheType.allCases.map { $0.rawValue },
                                selectedSubCategory: Clothe.ClotheType.Bottom.jeans.rawValue,
                                action: {}
                            )
                            
                            // Footwear Category
                            ClothesRowView(
                                categoryName: Clothe.ClotheType.footwear.rawValue,
                                subCategories: Clothe.ClotheType.Footwear.allCases.map { $0.rawValue },
                                selectedSubCategory: Clothe.ClotheType.Footwear.sneakers.rawValue,
                                action: {}
                            )
                            
                            // Accessories Category
                            ClothesRowView(
                                categoryName: Clothe.ClotheType.accessories.rawValue,
                                subCategories: Clothe.ClotheType.Accessory.allCases.map { $0.rawValue },
                                selectedSubCategory: Clothe.ClotheType.Accessory.necklace.rawValue,
                                action: {}
                            )
                            
                            // Outerwear Category
                            ClothesRowView(
                                categoryName: Clothe.ClotheType.outerwear.rawValue,
                                subCategories: Clothe.ClotheType.Outerwear.allCases.map { $0.rawValue },
                                selectedSubCategory: Clothe.ClotheType.Outerwear.hoodies.rawValue,
                                action: {}
                            )
                            
                            // Dresses Category
                            ClothesRowView(
                                categoryName: Clothe.ClotheType.dresses.rawValue,
                                subCategories: Clothe.ClotheType.Dress.allCases.map { $0.rawValue },
                                selectedSubCategory: Clothe.ClotheType.Dress.maxi.rawValue,
                                action: {}
                            )
                        }
                        
                        
                    }
                    .padding(.bottom, 100)
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
                        .shadow(color: Color.main.opacity(0.5), radius: 10)
                        .padding(.bottom, 20)
                        .sheet(isPresented: $showingSheet) {
                            StyleView(showingSheet: $showingSheet)
                                .presentationDetents([.fraction(CGFloat(0.4))])
                        }
                    })
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showAddClothesView.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 25))
                            }
                            
                        }
                    })
                }
            }
            .padding(.top)
            .navigationTitle("Wardrobe")
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
