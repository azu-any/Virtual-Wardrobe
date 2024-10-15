//
//  Virtual_WardrobeApp.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila on 08/10/24.
//

import SwiftUI
import SwiftData

@main
struct Virtual_WardrobeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Clothe.self)
                .modelContainer(for: Outfit.self)
        }
    }
}
