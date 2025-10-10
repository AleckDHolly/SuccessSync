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

    init(title: String, content: String, date: Date) {
        self.title = title
        self.content = content
        self.date = date
    }
}

extension JournalFolder {
    static func allJournals(with journals: [Journal]) -> JournalFolder {
        let virtualFolder = JournalFolder(title: allJournalsTitle, journals: journals)
        return virtualFolder
    }

    static let allJournalsTitle = "All Journals"
}

