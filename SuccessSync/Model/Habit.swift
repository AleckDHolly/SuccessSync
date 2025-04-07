//
//  Habit.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-06.
//

import Foundation
import SwiftUI

struct Habit: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    var datesCompleted: [Date]?
    
    mutating func markCompleted(at date: Date) {
        if datesCompleted == nil {
            datesCompleted = [date]
        } else {
            datesCompleted?.append(date)
        }
    }
}

let allHabits: [Habit] = [
    .init(name: "Drink water", color: .green, datesCompleted: [Date()]),
    .init(name: "Meditate", color: .blue),
    .init(name: "Read", color: .red),
    .init(name: "Exercise", color: .yellow),
    .init(name: "Learn something new", color: .purple),
]
