//
//  HabitsView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI

struct HabitsView: View {
    @State private var date: Date = Date()
    let habits: [Habit] = allHabits
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Your progress")
                        
                        Spacer()
                        
                        DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(.automatic)
                    }
                    
                    HStack {
                        Group {
                            Text("Today")
                                .font(.largeTitle)
                            Image(systemName: "pencil")
                                .font(.largeTitle)
                        }
                        
                        Spacer()
                        
                        Text("1/3")
                            .font(.title)
                            .foregroundStyle(.cyan)
                    }
                    .padding(.vertical)
                    
                    ProgressView(value: 1, total: 3)
                    
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
        }
    }
}

#Preview {
    HabitsView()
}
