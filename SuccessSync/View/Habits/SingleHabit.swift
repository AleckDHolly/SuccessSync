//
//  SingleHabit.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-06.
//

import SwiftUI

struct SingleHabit: View {
    @State var habit: Habit
    @State var selectedDate: Date = Date()
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Text(habit.name)
                    .font(.title3)
                
                Circle()
                    .fill(habit.color)
                    .frame(width: 12)
            }
            
            CalendarView(selectedDate: $selectedDate, datesCompleted: $habit.datesCompleted)
            
            HStack {
                Spacer()
                
                Button {
                    if !habit.datesCompleted.contains(selectedDate) {
                        habit.datesCompleted.append(selectedDate)
                    }
                    
                    print(habit.datesCompleted)
                } label: {
                    Text("Done")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    let habit = Habit(name: "Brush teeth", color: .cyan)
    SingleHabit(habit: habit)
}
