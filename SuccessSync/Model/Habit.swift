//
//  Habit.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-06.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Habit {
    var id = UUID()
    var name: String
    var colorHex: String
    var datesCompleted: [Date]?

    init(name: String, color: Color, datesCompleted: [Date]? = nil) {
        self.name = name
        self.colorHex = color.toHex()  // convert Color to hex string
        self.datesCompleted = datesCompleted
    }

    var color: Color {
        Color(hex: colorHex) ?? .blue  // fallback color if decoding fails
    }
}

let allHabits: [Habit] = [
    .init(name: "Drink water", color: .green, datesCompleted: [Date()]),
    .init(name: "Meditate", color: .blue),
    .init(name: "Read", color: .red),
    .init(name: "Exercise", color: .yellow),
    .init(name: "Learn something new", color: .purple),
]
