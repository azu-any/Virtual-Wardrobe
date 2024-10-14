//
//  WardrobeView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI

struct WardrobeView: View {
    
    @State private var showAddClothesView = false
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                
                
                VStack(spacing: 30){
                    
                    ClothesRowView(categoryName: "Top", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Bottom", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Footwear", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})
                    ClothesRowView(categoryName: "Accessories", subCategories: ["Tshirt", "Tshort"], selectedSubCategory: "Tshirt", action: {})

                    
                    
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddClothesView.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }

                    }
                })
                .padding(.top)
                .navigationTitle("Wardrobe")
            }
            .padding(.bottom, 120)
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
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.main)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 20)
            }
            .padding()
            .padding(.bottom, 20)
            .sheet(isPresented: $showingSheet) {
                StyleView()
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
