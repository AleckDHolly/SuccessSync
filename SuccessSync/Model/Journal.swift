//
//  Journal.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import Foundation
import SwiftData

@Model
class Journal {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    
    init(title: String, content: String, date: Date) {
        self.title = title
        self.content = content
        self.date = date
    }
}
