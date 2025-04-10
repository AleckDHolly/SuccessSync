//
//  HabitsView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import SwiftData

struct HabitsView: View {
    @State private var date: Date = Date()
    @Query private var habits: [Habit]
    @State private var addHabitSheet: Bool = false
    @State private var editHAbitSheet: Bool = false
    
    var completedHabitsCount: Int {
        habits.filter { habit in
            habit.datesCompleted.contains(where: {
                Calendar.current.isDate($0, inSameDayAs: date)
            })
        }.count
    }

    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Your progress")
                    
                    Spacer()
                    
                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.automatic)
                }
                .padding(.horizontal)
                
                HStack {
                    Group {
                        Text(Calendar.current.isDate(date, inSameDayAs: Date()) ? "Today" : date.formatted(date: .abbreviated, time: .omitted))
                            .font(.largeTitle)
                        Image(systemName: "pencil")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    Text("\(completedHabitsCount)/\(habits.count)")
                        .font(.title)
                        .foregroundStyle(.cyan)
                }
                .padding()
                
                if habits.count > 0 {
                    ProgressView(value: Float(completedHabitsCount), total: Float(habits.count))
                        .padding(.horizontal)
                } else {
                    EmptyView()
                        .padding(.horizontal)
                }
                
                ScrollView {
                    LazyVStack {
                        ForEach(habits) { habit in
                            SingleHabit(habit: habit)
                        }
                    }
                    .padding(.vertical)
                    .padding(.bottom, 75)
                }
            }
            
            Button {
                addHabitSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(.blue)
                    .clipShape(Circle())
                    .padding(30)
            }
            .buttonStyle(.plain)
        }
        .fullScreenCover(isPresented: $addHabitSheet, content: {
            AddHabitView()
        })
    }
}

#Preview {
    HabitsView()
}
