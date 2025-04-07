//
//  SingleHabit.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-06.
//

import SwiftUI

struct SingleHabit: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Text(habit.name)
                    .font(.title3)
                
                Circle()
                    .fill(habit.color)
                    .frame(width: 12)
            }
            
            CalendarView(datesCompleted: habit.datesCompleted ?? [])
            
            HStack {
                Spacer()
                
                Button {
                    
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
    SingleHabit(habit: allHabits[0])
}
