//
//  GoalsView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import SwiftData

struct GoalsView: View {
    @Query(sort: \Goal.dueDate) private var goals: [Goal]
    @State private var addGoal: Bool = false
    @State private var editGoal: Bool = false
    @State private var goal: Goal?
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            ZStack {
                if goals.isEmpty {
                    ContentUnavailableView("Add a goal to begin", systemImage: "chart.line.uptrend.xyaxis", description: Text("Add all of the goals you would like to achieve at a certain date of your choice."))
                    
                } else {
                    List {
                        ForEach(goals) { goal in
                            Button {
                                self.goal = goal
                                editGoal = true
                            } label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(goal.title)
                                        
                                        Spacer()
                                        
                                        Text(goal.dueDate.formatted(date: .abbreviated, time: .omitted))
                                            .foregroundStyle(.secondary)
                                        
                                    }
                                    
                                    if let reason = goal.reason, !reason.isEmpty {
                                        Text(reason)
                                            .multilineTextAlignment(.leading)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: delete)
                    }
                }
                
                if addGoal {
                    PopUpView(stillAddingGoal: $addGoal)
                }
                
                if let goal, editGoal {
                    PopUpView(goal: goal.title, date: goal.dueDate,reason: goal.reason ?? "", stillAddingGoal: $editGoal, currentGoal: goal)
                }
            }
            .navigationTitle("Goals")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        addGoal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let goal = goals[index]
            context.delete(goal)
        }
    }
}

#Preview {
    GoalsView()
}
