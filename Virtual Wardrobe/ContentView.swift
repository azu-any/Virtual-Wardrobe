import SwiftUI

struct ContentView: View {
    
    @State var selectedDay: Date = Date()
    
    var body: some View {
        
            TabView {
                CalendarView(selectedDay: $selectedDay)
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
            .accentColor(Color.main)
        }

}

#Preview {
    ContentView()
}
