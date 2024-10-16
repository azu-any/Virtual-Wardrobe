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
                                        //.foregroundColor(.foreground)
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
        .padding()
    }
    
}
