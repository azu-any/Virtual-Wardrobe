//
//  Calendar.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila on 08/10/24.
//


import SwiftUI 
import SwiftData


struct CalendarView: View {
    @Environment(\.modelContext) var context
    @Binding var selectedDay: Date
    @Query var outfits: [Outfit]
    @State private var selectedEmotion: Int?
    @State private var isPresented: Bool = false
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationStack{
                
            ScrollView{
                    
                VStack(alignment: .center){
                    
                    WeekCalendarView(selectedDay: $selectedDay)
                        .frame(height: 180)
                        //s.padding(.bottom, 1)
                    
                    if let myOutfit = outfitForSelectedDay() {
                        
                        if !myOutfit.clothes.isEmpty {
                            
                            Text("Outfit of \(selectedDay.formatted(date: .long, time: .omitted))")
                                .font(.title2)
                                .padding(.top, 10)
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                
                                Spacer()
                                    .containerRelativeFrame(.horizontal)
                                
                                HStack(alignment: .center, spacing: 10){
                                    
                                    
                                    
                                    ForEach(myOutfit.clothes) { clothe in
                                        NavigationLink {
                                            ClotheDetailView(clothe: clothe)
                                        } label: {
                                            ClothesCardView(clothe: clothe, size: 120)
                                            .contextMenu {
                                                
                                                Button{
                                                    isEditing = true
                                                } label: {
                                                    Label("Edit Outfit", systemImage: "pencil.circle")
                                                }
                                            }
                                        }
                                    }
                                        
                                }
                                
                                
                            }
                            .scrollBounceBehavior(.basedOnSize)
                            .padding(.bottom, 20)
                            .padding(.leading)
                            
                            
                            Text("Mood tracker")
                                .font(.title.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            
                            moodButtons()
                        } else {
                            AddOutfit(isPresented: $isPresented)
                        }
                
                    } else {
                        AddOutfit(isPresented: $isPresented)
                    }
                }
                
                Spacer()
            }
            .sheet(isPresented: $isPresented, content: {
                WardrobeSelectorView(selectedDay: $selectedDay, outfit: nil)
            })
            .sheet(isPresented: $isEditing, content: {
                WardrobeSelectorView(selectedDay: $selectedDay, outfit: outfitForSelectedDay())
            })
            .navigationTitle(Text("Calendar"))
            
            
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
                        outfitForSelectedDay()?.selectedEmotion = emotion
                    }) {
                        Text(emotion == 1 ? "🙁" : emotion == 2 ? "😐" : "🙂")
                            .padding(10)
                            .font(.system(size: 64))
                            .background(outfitForSelectedDay()?.selectedEmotion == emotion ? Color.main : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
        }
    
    

}


struct AddOutfit: View {
    @Binding var isPresented: Bool
    
     var body: some View {
        VStack{
            Button(action: {
                isPresented.toggle()
            }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 150))
                        .padding(10)
                        .foregroundColor(.main)
                    
                    
                }
            
            Text("No outfits for today")
            .font(.callout)
            .padding()
        
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var date: Date = Date()
    CalendarView(selectedDay: $date)
        .padding()
}
