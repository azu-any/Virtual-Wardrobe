//
//  StyleGeneratedView.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila Cerón on 14/10/24.
//

import SwiftUI

struct StyleGeneratedView: View {
    
    @State var clothes = []
    @Binding var generateOutfit: Bool
    @Binding var showingSheet: Bool
    
    var body: some View {
        
        VStack(spacing: 20){
            
            Text("Let's take a look!")
                .font(.title2.bold())
            
            VStack(){
                HStack{
                    
                }
                
                HStack{
                    
                }
            }
            
            Button(action: {
                generateOutfit = false
                showingSheet = false
            }){
                Text("Add outfit to the calendar")
                    .font(.headline.bold())
            }
            .buttonStyle(MainButton())
            
            Button(action: {
                showingSheet = true
                generateOutfit = false
                
            }){
                Label("Generate again", systemImage: "arrow.trianglehead.2.clockwise")
                    .labelStyle(MainLabel())
            }
        }
        
    }
}

#Preview {
    StyleGeneratedView(generateOutfit: .constant(true),
        showingSheet: .constant(true))
}
