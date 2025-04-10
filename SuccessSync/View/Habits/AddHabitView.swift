//
//  AddHabitView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-09.
//

import SwiftUI

struct AddHabitView: View {
    @State private var habit: String = ""
    @FocusState private var isFocused: Bool
    @State private var selectedColor: Color = .blue
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("x")
                        .font(.largeTitle)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(Circle())
                        .padding()
                }
            }
            
            TextField("Add a habit", text: $habit)
                .focused($isFocused)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 3)
                )
                .padding()
            
            
            ColorPicker(selection: $selectedColor) {
                Text("Select a color:")
                    .font(.title2)
            }
                .padding()
            
            Button {
                if !habit.isEmpty {
                    let habit = Habit(name: habit, color: selectedColor)
                    context.insert(habit)
                    try? context.save()
                }
                dismiss()
            } label: {
                Text("Save")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AddHabitView()
}
