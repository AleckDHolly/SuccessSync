//
//  Goal.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-09.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Goal {
    var id = UUID()
    var title: String
    var reason: String?
    var dueDate: Date
    
    init(title: String, dueDate: Date, reason: String? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.reason = reason
    }
}
