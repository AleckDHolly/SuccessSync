//
//  PopUpView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-10.
//

import SwiftUI

struct PopUpView: View {
    @State var goal: String = ""
    @Environment(\.dismiss) var dismiss
    @State var date: Date = Date()
    @State var reason: String = ""
    @Environment(\.modelContext) private var context
    @Binding var stillAddingGoal: Bool
    @State var currentGoal: Goal?
    
    var body: some View {
        VStack {
            TextField("Add a Goal..", text: $goal)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 1.5)
                )
                .padding()
            
            TextField("Add your reason..", text: $reason, axis: .vertical)
                .lineLimit(4)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 1.5)
                )
                .padding(.horizontal)
                .padding(.bottom)
            
            DatePicker("Add a deadline", selection: $date, displayedComponents: .date)
                .datePickerStyle(.automatic)
                .padding(.horizontal)
            
            HStack {
                Button("Cancel", role: .cancel) {
                    stillAddingGoal = false
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                Divider()
                    .frame(maxHeight: .infinity)
                
                Button(currentGoal != nil ? "Edit Goal" : "Add Goal") {
                    if let currentGoal, !goal.isEmpty {
                        currentGoal.title = goal
                        currentGoal.reason = reason
                        currentGoal.dueDate = date
                    } else {
                        let goal = Goal(title: goal, dueDate: date, reason: reason)
                        context.insert(goal)
                    }
                    stillAddingGoal = false
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(height: 50)
            .background(.ultraThickMaterial)
            .padding(.top)
            
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    func deleteGoal() {
        if let currentGoal {
            context.delete(currentGoal)
            stillAddingGoal = false
        }
    }
}

#Preview {
    PopUpView(stillAddingGoal: .constant(false))
}
