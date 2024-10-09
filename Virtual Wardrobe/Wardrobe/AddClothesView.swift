//
//  AddClothesView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI

struct AddClothesView: View {
    
    @Binding var showAddClothesView: Bool
    @State private var color: Color = Color.blue
    let subCategories: [String] = ["Jeans", "T-Shirt"]
    @State var selectedSubCategory: String = "Jeans"
    
    var body: some View {
        NavigationStack{
            VStack{
                Button {
                    ///Show photo menu
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.30))
                            .frame(width: 200, height: 200)
                        
                        Image(systemName: "camera.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.gray)
                            
                    }
                    .padding(.bottom)
                }

                
                VStack(spacing: 20){
                    ColorPicker("Color", selection: $color)
                    HStack{
                        Text("Type")
                        Spacer()
                        Picker("Picker", selection: $selectedSubCategory) {
                            ForEach(subCategories, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                .frame(width: 200)
                
                Button("Save item"){
                    
                }
                .buttonStyle(MainButton())
                .padding(.top, 50)
                
                
            }
            .navigationTitle("Add new clothes")
        }
    }
}

#Preview {
    AddClothesView(showAddClothesView: .constant(true))
}
