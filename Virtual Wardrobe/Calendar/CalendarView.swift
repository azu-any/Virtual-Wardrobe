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
    //@State var myOutfit: Outfit? // = .init(clothes: [], date: Date())
    @State var myOutfit: Outfit = Outfit(clothes: [], createdDate: Date())
    @State private var selectedEmotion: Int?
    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack{
            
                VStack(alignment: .center){
                    
                    WeekCalendarView(selectedDay: $selectedDay)
                        .frame(height: 170)
                    
                    ScrollView{
                        // OUTFIT
                        if let myOutfit = outfitForSelectedDay() {
                            //myOutfit = outfit // Keep myOutfit updated
                            
                            HStack{
                                ForEach(myOutfit.clothes) { clothe in
                                    
                                    ClothesCardView(clothe: clothe)
                                }
                            }

                            
                            Text("Mood tracker")
                                .font(.title.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()

                            /*HStack(spacing: 20){
                                
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
                            }*/
                            moodButtons()
                    
                        } else {
                            
                            Button(action:{
                                isPresented = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 124, height: 124)
                                    .foregroundColor(.main)
                                    .padding()
                            }
                            Text("No outfits for today")
                                .font(.callout)
                                .padding()
                            
                            
                            
                        }
                    }
                    
                }
                .sheet(isPresented: $isPresented, content: {
                    WardrobeSelectorView(myOutfit: $myOutfit, selectedDay: $selectedDay)
                })
                .navigationTitle(Text("Calendar"))
                
                Spacer()
                
            
        }
        
    }
    
    private func outfitForSelectedDay() -> Outfit? {
           let calendar = Calendar.current
           let componentsToCheck = calendar.dateComponents([.year, .month, .day], from: selectedDay)

           return outfits.first { outfit in
               let outfitComponents = calendar.dateComponents([.year, .month, .day], from: outfit.createdDate)
               return outfitComponents == componentsToCheck
           }
       }
    
    
    private func moodButtons() -> some View {
            HStack(spacing: 20) {
                ForEach(1...3, id: \.self) { emotion in
                    Button(action: {
                        selectedEmotion = emotion
                    }) {
                        Text(emotion == 1 ? "🙂" : emotion == 2 ? "😐" : "🙁")
                            .padding(10)
                            .font(.system(size: 64))
                            .background(selectedEmotion == emotion ? Color.main : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
        }
    

}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var date: Date = Date()
    CalendarView(selectedDay: $date)
        .padding()
}
