//
//  SwiftUIView.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila on 08/10/24.
//

import SwiftUI

struct MainButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.main)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
    }
}

struct MainLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
                configuration.icon
                    .foregroundColor(.secondary)
                configuration.title
                }
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.main, lineWidth: 2))
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
    }
}

struct ButtonView: View {
    var body: some View {
        Button("Press Me"){
            print("Nothing")
        }
        .buttonStyle(MainButton())
        
        Label("Press me", systemImage: "folder")
            .labelStyle(MainLabel())
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ButtonView()
        .padding()
}
