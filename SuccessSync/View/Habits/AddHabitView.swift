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
    
    @State var isBeingEdited: Bool?
    @State var habitToEdit: Habit?
    @Query var habits: [Habit]
    
    var body: some View {
        VStack {
            TextField("Add a habit", text: $habit)
                .focused($isFocused)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 1.5)
                )
                .padding(.top, 20)
            
            
            ColorPicker(selection: $selectedColor) {
                Text("Select a color:")
                    .font(.title2)
            }
            .padding(.vertical)
                .padding(.vertical, 20)
            
            HStack {
                if let habitToEdit, isBeingEdited == true {
                    Button {
                        context.delete(habitToEdit)
                        try? context.save()
                    } label: {
                        Text("Delete")
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                    
                    Divider()
                        .frame(maxHeight: .infinity)
                }
                
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
                } label: {
                    Text("Save")
                        .font(.title2)
                        .foregroundStyle(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
            .frame(height: 50)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            
        }
        .onAppear {
            isFocused = true
        }
        .padding()
    }
}

#Preview {
    AddHabitView()
}
