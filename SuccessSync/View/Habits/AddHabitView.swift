//
//  AddHabitView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-09.
//

import SwiftUI
import SwiftData

struct AddHabitView: View {
    @State var habit: String = ""
    @FocusState private var isFocused: Bool
    @State var selectedColor: Color = .blue
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var isBeingEdited: Bool?
    @State var habitToEdit: Habit?
    @Query var habits: [Habit]
    
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
                if isBeingEdited == true {
                    if !habit.isEmpty {
                        habitToEdit?.name = habit
                        habitToEdit?.colorHex = selectedColor.toHex()
                        try? context.save()
                        print(habits)
                    }
                } else {
                    if !habit.isEmpty {
                        let habit = Habit(name: habit, color: selectedColor)
                        context.insert(habit)
                        try? context.save()
                        print(habits)
                    }
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
            
            if let habitToEdit, isBeingEdited == true {
                Button {
                    context.delete(habitToEdit)
                    try? context.save()
                    
                    dismiss()
                } label: {
                    Text("Delete the habit: \"\(habitToEdit.name)\"")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                .buttonStyle(.plain)
            }
            
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
