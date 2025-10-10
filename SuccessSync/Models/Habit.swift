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
    var datesCompleted: [Date]

    init(name: String, color: Color, datesCompleted: [Date] = []) {
        self.name = name
        self.colorHex = color.toHex()  // convert Color to hex string
        self.datesCompleted = datesCompleted
    }

    var color: Color {
        Color(hex: colorHex) ?? .blue  // fallback color if decoding fails
    }
}
