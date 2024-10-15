//
//  StyleGeneratedView.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila Cerón on 14/10/24.
//

import SwiftUI

struct StyleGeneratedView: View {
    
    @State var clothes = []
    
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
            
            Button(action: {}){
                Text("Add outfit to the calendar")
                    .font(.headline.bold())
            }
            .buttonStyle(MainButton())
            
            Button(action: {}){
                Label("Generate again", systemImage: "arrow.trianglehead.2.clockwise")
                    .labelStyle(MainLabel())
            }
        }
        
    }
}

#Preview {
    StyleGeneratedView()
}
