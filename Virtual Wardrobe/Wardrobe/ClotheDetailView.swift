//
//  ClotheDetailView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 14/10/24.
//

import SwiftUI

struct ClotheDetailView: View {
    
    let clothe: Clothe
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Image(uiImage: UIImage(data: Data(clothe.image ?? Data()))!)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack{
                    Text("Color")
                    Spacer()
                    Circle()
                        .fill(Color(red: Double(clothe.redAmount), green: Double(clothe.greenAmount), blue: Double(clothe.blueAmount)))
                        .frame(width: 20)
                }
                
                HStack{
                    Text("Type")
                    Spacer()
                    Text(clothe.type)
                        .foregroundStyle(.secondary)
                }
                
                HStack{
                    Text("Times used")
                    Spacer()
                    Text("\(clothe.timesUsed)")
                }
            }
            .frame(width: 200)
        }
        .onAppear {
            print(clothe.blueAmount)
        }
    }
}

//#Preview {
//    ClotheDetailView()
//}
