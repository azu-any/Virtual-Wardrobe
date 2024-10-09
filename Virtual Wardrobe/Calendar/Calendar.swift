//
//  Calendar.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila on 08/10/24.
//


import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationStack{
            VStack{
                
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    .datePickerStyle(.graphical)

            }
            .navigationTitle(Text("Calendar"))
        }
       
        
        
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CalendarView()
        .padding()
}
