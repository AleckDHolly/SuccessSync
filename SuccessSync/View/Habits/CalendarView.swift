//
//  CalendarView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-06.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State private var currentWeekIndex = 0
    @Binding var datesCompleted: [Date]

    private let numberOfWeeks = 200
    private let calendar = Calendar.current

    private var baseWeekStart: Date {
        calendar.startOfWeek(for: Date())
    }

    private var allWeekStartDates: [Date] {
        let range = -numberOfWeeks/2..<numberOfWeeks/2
        return range.map { offset in
            calendar.date(byAdding: .weekOfYear, value: offset, to: baseWeekStart)!
        }
    }

    private var currentWeekStart: Date {
        allWeekStartDates[currentWeekIndex]
    }

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $currentWeekIndex) {
                ForEach(allWeekStartDates.indices, id: \.self) { index in
                    let weekStart = allWeekStartDates[index]
                    let weekDates = (0..<7).compactMap {
                        calendar.date(byAdding: .day, value: $0, to: weekStart)
                    }

                    HStack(spacing: 12) {
                        ForEach(weekDates, id: \.self) { date in
                            VStack {
                                Text(date.formatted(.dateTime.weekday(.abbreviated))) // "Sun"
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(date.formatted(.dateTime.day())) // "6"
                                    .frame(width: 40, height: 40)
                                    .background(
                                        calendar.isDate(date, inSameDayAs: selectedDate)
                                        ? Color.blue
                                        : (datesCompleted.contains { calendar.isDate($0, inSameDayAs: date) } ? Color.blue.opacity(0.5) : Color.clear)
                                    )
                                
                                    .foregroundColor(foregroundColor(date: date))
                                    .clipShape(Circle())
                            }
                            .onTapGesture {
                                if date < Date() {
                                    selectedDate = date
                                }
                            }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
        }
        .onAppear {
            if let todayIndex = allWeekStartDates.firstIndex(where: {
                calendar.isDate(selectedDate, equalTo: $0, toGranularity: .weekOfYear)
            }) {
                currentWeekIndex = todayIndex
            }
        }
        .animation(.easeInOut(duration: 0.25), value: currentWeekIndex)
    }
    
    func foregroundColor(date: Date) -> Color {
        if calendar.isDate(date, inSameDayAs: selectedDate) {
            return .white
        } else if date > Date() {
            return .gray
        } else {
            return .primary
        }
    }
}

extension Calendar {
    func startOfWeek(for date: Date) -> Date {
        let components = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return self.date(from: components) ?? date
    }
}


#Preview {
    CalendarView(selectedDate: .constant(Date()), datesCompleted: .constant([Date()]))
}
