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
    
    var container: ModelContainer

    init() {
        do {
            let config1 = ModelConfiguration(for: Clothe.self)
            let config2 = ModelConfiguration(for: Outfit.self, isStoredInMemoryOnly: false)

            container = try ModelContainer(for: Clothe.self, Outfit.self, configurations: config1, config2)
        } catch {
            print("Error: \(error)")
            fatalError("Failed to configure SwiftData container.")
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
