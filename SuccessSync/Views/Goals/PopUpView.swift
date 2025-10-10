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
    @State var currentGoal: Goal?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Add a Goal..", text: $goal)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary, lineWidth: 1.5)
                    )
                    .padding(.vertical)
                
                TextField("Add your reason..", text: $reason, axis: .vertical)
                    .lineLimit(4)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary, lineWidth: 1.5)
                    )
                    .padding(.bottom)
                
                DatePicker("Add a deadline:", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                
                Spacer()
                
                HStack {
                    Button(currentGoal != nil ? "Edit Goal" : "Add Goal") {
                        if let currentGoal, !goal.isEmpty {
                            currentGoal.title = goal
                            currentGoal.reason = reason
                            currentGoal.dueDate = date
                        } else  {
                            if !goal.isEmpty {
                                let goal = Goal(title: goal, dueDate: date, reason: reason)
                                context.insert(goal)
                            }
                        }
                        
                        dismiss()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(height: 50)
                .background(.ultraThickMaterial)
                .cornerRadius(10)
                .padding(.bottom)
                
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.primary)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

#Preview {
    PopUpView()
}
