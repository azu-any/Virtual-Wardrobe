import SwiftUI

struct ContentView: View {
    var body: some View {
        
            TabView {
                Calender()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                
                Style()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Style")
                    }
                
                WardrobeView()
                    .tabItem {
                        Image(systemName: "tshirt.fill")
                        Text("Wardrobe")
                    }
            }
        }

}

#Preview {
    ContentView()
}
