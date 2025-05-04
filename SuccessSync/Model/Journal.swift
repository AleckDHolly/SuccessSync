//
//  Journal.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import Foundation
import SwiftData

@Model
class JournalFolder {
    var id = UUID()
    var title: String
    var journals: [Journal]

    init(title: String, journals: [Journal]) {
        self.title = title
        self.journals = journals
    }
}

@Model
class Journal {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    var folder: JournalFolder?

    init(title: String, content: String, date: Date, folder: JournalFolder? = nil) {
        self.title = title
        self.content = content
        self.date = date
        self.folder = folder
    }
}

