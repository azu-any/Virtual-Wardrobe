//
//  Calendar.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila on 08/10/24.
//


import SwiftUI 
import SwiftData


struct CalendarView: View {
    @Binding var selectedDay: Date
    @Query var outfits: [Outfit]
    @State private var selectedEmotion: Int?

    var body: some View {
        NavigationStack{
            
                VStack(alignment: .center){
                    
                    WeekCalendarView(selectedDay: $selectedDay)
                        .frame(height: 170)
                    
                    // LOGIC
                    // if outfit for today
                    
                    ScrollView{
                        // OUTFIT
                        if !outfits.isEmpty {
                            
                            HStack{
                                ForEach(outfits) { outfit in
                                    ForEach(outfit.clothes) { clothe in
                                        
                                        Image(uiImage: UIImage(data: clothe.image ?? Data())!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 200, height: 200)
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    
                                }
                            }

                            
                            Text("Mood tracker")
                                .font(.title.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()

                            HStack(spacing: 20){
                                
                                Button(action: {
                                    selectedEmotion = 1
                                }){
                                    Text("🙂")
                                        .padding(10)
                                        .font(.system(size: 64))
                                        .background(selectedEmotion == 1 ? Color.main : Color.clear)
                                        .clipShape(Circle())
                                }
                                
                                Button(action: {
                                    selectedEmotion = 2
                                }){
                                    Text("😐")
                                        .padding(10)
                                        .font(.system(size: 64))
                                        .background(selectedEmotion == 2 ? Color.main : Color.clear)
                                        .clipShape(Circle())
                                }
                                
                                Button(action: {
                                    selectedEmotion = 3
                                }){
                                    Text("🙁")
                                        .padding(10)
                                        .font(.system(size: 64))
                                        .background(selectedEmotion == 3 ? Color.main : Color.clear)
                                        .clipShape(Circle())
                                }
                            }
                            
                    
                        } else {
                            
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 124, height: 124)
                                .foregroundColor(.main)
                                .padding()
                            
                            Text("No outfits for today")
                                .font(.callout)
                                .padding()
                            
                            
                        }
                    }
                    
                }
                .navigationTitle(Text("Calendar"))
                
                Spacer()
                
            
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var date: Date = Date()
    CalendarView(selectedDay: $date)
        .padding()
}
