
//
//  WardrobeView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI
import SwiftData

struct WardrobeSelectorView: View {
    @Environment(\.modelContext) private var context
    @State private var showAddClothesView = false
    @State private var showingSheet = false
    @Environment(\.presentationMode) var mode
    
    @Query var clothes: [Clothe]
    @Query var outfits: [Outfit]
    @Binding var selectedDay: Date
    @State var myOutfit: Outfit

    init(selectedDay: Binding<Date>, outfit: Outfit? = nil) {
        _selectedDay = selectedDay
        
        _myOutfit = State(initialValue: outfit ?? Outfit(clothes: [], createdDate: selectedDay.wrappedValue))
    }
    
    
    var body: some View {
        NavigationStack{
            VStack{
                if clothes.isEmpty{
                    emptyWardrobeView
                }else{
                    ScrollView {
                        
                        VStack(spacing: 30){
                            
                            
                            // Tops Category
                            ClothesRowSelectorView(
                                categoryName: Clothe.ClotheType.top.rawValue,
                                subCategories: Clothe.ClotheType.top.subCategoriesOnly(),
                                selectedSubCategory: Clothe.ClotheType.Top.tShirt.rawValue,
                                action: {}, myOutfit: $myOutfit
                            )
                            
                            // Bottoms Category
                            ClothesRowSelectorView(
                                categoryName: Clothe.ClotheType.bottom.rawValue,
                                subCategories: Clothe.ClotheType.bottom.subCategoriesOnly(),
                                selectedSubCategory: Clothe.ClotheType.Bottom.jeans.rawValue,
                                action: {}, myOutfit: $myOutfit
                            )
                            
                            // Footwear Category
                            ClothesRowSelectorView(
                                categoryName: Clothe.ClotheType.footwear.rawValue,
                                subCategories: Clothe.ClotheType.footwear.subCategoriesOnly(),
                                selectedSubCategory: Clothe.ClotheType.Footwear.sneakers.rawValue,
                                action: {}, myOutfit: $myOutfit
                            )
                            
                            // Accessories Category
                            ClothesRowSelectorView(
                                categoryName: Clothe.ClotheType.accessories.rawValue,
                                subCategories: Clothe.ClotheType.accessories.subCategoriesOnly(),
                                selectedSubCategory: Clothe.ClotheType.Accessory.necklace.rawValue,
                                action: {}, myOutfit: $myOutfit
                            )
                            
                            // Outerwear Category
                            ClothesRowSelectorView(
                                categoryName: Clothe.ClotheType.outerwear.rawValue,
                                subCategories: Clothe.ClotheType.outerwear.subCategoriesOnly(),
                                selectedSubCategory: Clothe.ClotheType.Outerwear.hoodies.rawValue,
                                action: {}, myOutfit: $myOutfit
                            )
                            
                            // Dresses Category
                            ClothesRowSelectorView(
                                categoryName: Clothe.ClotheType.dresses.rawValue,
                                subCategories: Clothe.ClotheType.dresses.subCategoriesOnly(),
                                selectedSubCategory: Clothe.ClotheType.Dress.maxi.rawValue,
                                action: {}, myOutfit: $myOutfit
                            )
                            /*ClothesRowSelectorView(categoryName: "Tops", subCategories: ["T-Shirts", "Jackets", "Coats", "Sweaters", "Hoodies", "Shirts", "Blouses"], selectedSubCategory: "T-Shirts", action: {}, myOutfit: $myOutfit)
                            
                            ClothesRowSelectorView(categoryName: "Bottom", subCategories: ["Jeans", "Shorts", "Skirts", "Leggings"], selectedSubCategory: "Jeans", action: {}, myOutfit: $myOutfit)
                            
                            ClothesRowSelectorView(categoryName: "Footwear", subCategories: ["Sneakers"], selectedSubCategory: "Sneakers", action: {}, myOutfit: $myOutfit)
                            
                            ClothesRowSelectorView(categoryName: "Accessories", subCategories: ["Necklace", "Earrings", "Bracelet", "Watch", "Glasses"], selectedSubCategory: "Necklace", action: {}, myOutfit: $myOutfit)*/
                        }
                    }
                    .padding(.bottom, 100)
                    .overlay(alignment: .bottom, content: {
                        Button(
                            action:{
                                myOutfit.createdDate = selectedDay
                                context.insert(myOutfit)
                                mode.wrappedValue.dismiss()
                            }
                            
                        ) {
                                Text("Add Outfit")
                                    .font(.title2.bold())
                            
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

extension WardrobeSelectorView{
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
