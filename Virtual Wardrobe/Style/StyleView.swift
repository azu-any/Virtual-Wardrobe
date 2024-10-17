//
//  ContentView.swift
//  Style
//
//  Created by Muhammad Aun e Ali Mirza on 09/10/24.
//

import SwiftUI
import SwiftData

struct StyleView: View {
    @Environment(\.modelContext) private var context
    @State private var isToggled: Bool = true
    @State private var generateOutfit: Bool = false
    @Binding var showingSheet: Bool
    
    @Query var clothes: [Clothe]
    
    @State var dict: [String: [Clothe]]?
    
    @State private var oufit: Outfit?
    @State private var generatedClothes: [Clothe]?

    
    let top = ["T-Shirts", "Jackets", "Coats", "Sweaters", "Hoodies", "Shirts", "Blouses"]
    let bottom = ["Jeans", "Shorts", "Skirts", "Leggings"]
    let footwear = ["Sneakers"]
    let accessories = ["Necklace", "Earrings", "Bracelet", "Watch", "Glasses"]
    

    var body: some View {
        ZStack {
            if let generatedClothes{
                VStack{
                    Text("Your generated outfit")
                        .bold()
                        .padding()
                        .font(.title)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(generatedClothes){ clothe in
                                ClothesCardView(clothe: clothe)
                            }
                        }
                    }
                    .padding(.leading)
                    
                    Button(action: {
                        
                        generateOutfit = true
                        showingSheet = false
                        
                        //Add outfit to calendar
                        
                        context.insert(Outfit(clothes: generatedClothes))
                        
                        self.generatedClothes = nil
                    }){
                        Text("Add outfit to the calendar")
                            .font(.headline.bold())
                    }
                    .buttonStyle(MainButton())
                    
                    Button(action: {
                        generateOutfit = true
                        self.generatedClothes = nil
                        self.generatedClothes = generateRandomOutfit()
                        
                    }){
                        Label("Generate again", systemImage: "arrow.trianglehead.2.clockwise")
                            .labelStyle(MainLabel())
                    }
                }
            }else{
                VStack(spacing: 40){
                    HStack {
                        Text("Accessories")
                            .font(.headline)
                            .padding(.bottom, 15)
                        
                        
                        
                        Spacer()
                        
                        
                        Toggle(isOn: $isToggled) {
                        }
                        .labelsHidden()
                    }
                    .padding(.horizontal, 40)
                    
                    Button(action: {
                        generatedClothes = []
                        generateOutfit = true
                        generatedClothes = generateRandomOutfit()
                    }) {
                        Text("Outfit Me")
                    }
                            .buttonStyle(MainButton())
                        
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                        
                        Text("Our AI algorithm will generate the best outfit feed based on your preference.")
                            .font(.body)
                            .padding(.horizontal, 40)
                            .foregroundColor(.gray)
                    }
                .sheet(isPresented: $generateOutfit, content: {
                    StyleGeneratedView(generateOutfit: $generateOutfit, showingSheet: $showingSheet, generatedClothes: generatedClothes ?? [])})
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            
            
            
        }
        .onAppear {
            dict = categorizedItems()
            if let dict{
                print(dict.count)
            }
        }
        
    }
    
    func categorizedItems() -> [String : [Clothe]]?{
        
        var dict : [String : [Clothe]] = [
            "Top" : [],
            "Bottom" : [],
            "Footwear" : [],
            "Accessory" : []
        ]
        
        for category in top{
            for clothe in clothes{
                if category.contains(clothe.type.rawValue){
                    dict["Top"]?.append(clothe)
                    print("here")
                }
            }
        }
        
        for category in bottom{
            for clothe in clothes{
                if category.contains(clothe.type.rawValue){
                    dict["Bottom"]?.append(clothe)
                    print("here")
                }
            }
        }
        
        for category in footwear{
            for clothe in clothes{
                if category.contains(clothe.type.rawValue){
                    dict["Footwear"]?.append(clothe)
                    print("here")
                }
            }
        }
        
        for category in accessories{
            for clothe in clothes{
                if category.contains(clothe.type.rawValue){
                    dict["Accessory"]?.append(clothe)
                    print("here")
                }
            }
        }
        
        return dict
    }
    
    func generateRandomOutfit() -> [Clothe]? {
            var selectedOutfit: [Clothe] = []
            
            if let dict = dict {
                // Select one item from each category
                if let tops = dict["Top"], let randomTop = tops.randomElement() {
                    selectedOutfit.append(randomTop)
                }
                
                if let bottoms = dict["Bottom"], let randomBottom = bottoms.randomElement() {
                    selectedOutfit.append(randomBottom)
                }
                
                if let footwears = dict["Footwear"], let randomFootwear = footwears.randomElement() {
                    selectedOutfit.append(randomFootwear)
                }
                
                if let accessoryItems = dict["Accessory"], let randomAccessory = accessoryItems.randomElement() {
                    selectedOutfit.append(randomAccessory)
                }
            }
            
            return selectedOutfit.isEmpty ? nil : selectedOutfit
        }
    
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StyleView(showingSheet: .constant(true))
    }
}

