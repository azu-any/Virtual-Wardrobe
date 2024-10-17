import SwiftUI

struct ContentView: View {
    
    @State var selectedDay: Date = Date()
    
    var body: some View {
        
            TabView {
                
                WardrobeView()
                    .tabItem {
                        Image(systemName: "tshirt.fill")
                        Text("Wardrobe")
                    }
                
                CalendarView(selectedDay: $selectedDay)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
            }
            .accentColor(Color.main)
        }

}

#Preview {
    ContentView()
}
