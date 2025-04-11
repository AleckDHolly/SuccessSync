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
    @State private var editHabit: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Text(habit.name)
                    .font(.title3)
                
                Circle()
                    .fill(habit.color)
                    .frame(width: 12)
                
                Spacer()
                
                Button {
                    editHabit = true
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                .buttonStyle(.plain)
            }
            
            CalendarView(selectedDate: $selectedDate, datesCompleted: $habit.datesCompleted)
            
            HStack {
                Spacer()
                
                Button {
                    let selectedDay = Calendar.current.startOfDay(for: selectedDate)
                    habit.datesCompleted.removeAll {
                        Calendar.current.isDate(Calendar.current.startOfDay(for: $0), inSameDayAs: selectedDay)
                    }
                    
                    print(habit.datesCompleted)
                } label: {
                    Text("Undone")
                }
                .buttonStyle(.bordered)
                
                Button {
                    let selectedDay = Calendar.current.startOfDay(for: selectedDate)
                    let alreadyDone = habit.datesCompleted.contains {
                        Calendar.current.isDate(Calendar.current.startOfDay(for: $0), inSameDayAs: selectedDay)
                    }
                    if !alreadyDone {
                        habit.datesCompleted.append(selectedDay)
                    }
                    
                    print(habit.datesCompleted)
                } label: {
                    Text("Done")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(habit.color.opacity(0.2))
        .background(.ultraThinMaterial.opacity(0.8))
        .cornerRadius(10)
        .fullScreenCover(isPresented: $editHabit, content: {
            AddHabitView(habit: habit.name, selectedColor: habit.color, isBeingEdited: true, habitToEdit: habit)
        })
    }
}

#Preview {
    let habit = Habit(name: "Brush teeth", color: .cyan)
    SingleHabit(habit: habit)
}
