//
//  ContentView.swift
//  Style
//
//  Created by Muhammad Aun e Ali Mirza on 09/10/24.
//

import SwiftUI

struct Styleview: View {
    @State private var isToggled: Bool = true

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Style")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 80)
                    .padding(.leading, 10)
                
                Divider()
                    .padding(.leading, 1)
                
                Spacer()
            }
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
                    print("Button tapped!")
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .edgesIgnoringSafeArea(.all)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Styleview()
    }
}

