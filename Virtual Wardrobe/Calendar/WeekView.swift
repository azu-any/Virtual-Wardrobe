//
//  WeekView.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila Cerón on 09/10/24.
//


import SwiftUI
import Foundation

public struct WeekView: View {
    
    var week: Week
    @Binding var selectedDay: Date
    
    private let accentCircleColor: Color
    private let accentTextColor: Color
    private let defaultTextColor: Color
    private let font: Font
    private let circleHeight: CGFloat
    
    @State private var showDatePicker = false // State variable to control the visibility of the date picker

    
    init(
        week: Week,
        selectedDay: Binding<Date>,
        accentCircleColor: Color,
        accentTextColor: Color,
        defaultTextColor: Color,
        font: Font,
        circleHeight: CGFloat
    ) {
        self.week = week
        _selectedDay = selectedDay
        self.accentCircleColor = accentCircleColor
        self.accentTextColor = accentTextColor
        self.defaultTextColor = defaultTextColor
        self.font = font
        self.circleHeight = circleHeight
    }
        
    public var body: some View {
        VStack{
            
            HStack {
                Text(week.dates[0], format: .dateTime.month(.wide))
                    .font(.title3.bold())
                    .textCase(.uppercase)
                
                Button{
                    showDatePicker = true
                } label : {
                    Image(systemName: "calendar")
                        .foregroundColor(.main)
                }
                
            }
            .padding(.bottom, 10)
            
            HStack {
                
                ForEach(week.dates, id: \.self) { date in
                    
                    VStack {
                        
                        Text(date.formatted(.dateTime.weekday(.narrow)).capitalized)
                            .foregroundColor(defaultTextColor)
                            .font(.caption.bold())
                            .frame(maxWidth: .infinity)
                        
                        Circle()
                            .foregroundColor(date.isSameDay(with: selectedDay) && !date.isToday ? accentCircleColor.opacity(0.5) : .clear)
                            .frame(height: circleHeight)
                            .overlay {
                                ZStack {
                                    if date.isToday {
                                        Circle()
                                            .foregroundColor(accentCircleColor)
                                            .frame(height: circleHeight)
                                    }
                                    
                                    Text(date.formatted(.dateTime.day()))
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(date.isToday || date.isSameDay(with: selectedDay) ? .foreground : defaultTextColor)
                                }
                            }
                    }.onTapGesture {
                        selectedDay = date
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .sheet(isPresented: $showDatePicker) {
            DatePicker("", selection: $selectedDay, displayedComponents: .date)
                .labelsHidden() // Hides the default label
                .foregroundColor (.main)
                .datePickerStyle(GraphicalDatePickerStyle())
                .font(.title3)
                .presentationDetents([.fraction(CGFloat(0.5))])
        }
        
    }
    
}


struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Divider()
                HStack {
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("Save".uppercased())
                            .bold()
                    })
                    
                }
                .padding(.horizontal)

            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )

            
        }

    }
}
