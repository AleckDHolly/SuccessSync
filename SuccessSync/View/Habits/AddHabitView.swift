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
    @State var selectedColor: Color = .blue
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var isBeingEdited: Bool?
    @State var habitToEdit: Habit?
    @Query var habits: [Habit]
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Add a habit", text: $habit)
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
                
                Spacer()
                
                HStack {
                    if habitToEdit != nil, isBeingEdited == true {
                        Button {
                            showAlert = true
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
                                dismiss()
                            }
                        } else {
                            if !habit.isEmpty {
                                let habit = Habit(name: habit, color: selectedColor)
                                context.insert(habit)
                                try? context.save()
                                dismiss()
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
            .padding()
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
            .alert("Are you sure?", isPresented: $showAlert) {
                Button("No", role: .cancel) {
                    
                }
                
                Button("Yes", role: .destructive) {
                    if let habitToEdit {
                        context.delete(habitToEdit)
                        try? context.save()
                    }
                    dismiss()
                }
            } message: {
                Text("\"\(habitToEdit?.name ?? "")\" will be deleted.")
            }
        }
    }
}

#Preview {
    AddHabitView()
}
