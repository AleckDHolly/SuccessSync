//
//  Journal.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import Foundation
import SwiftData
import Observation

@Model
class JournalFolder {
    var id = UUID()
    var title: String
    @Relationship(deleteRule: .cascade) var journals: [Journal]

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
    @Relationship var folder: JournalFolder?

    init(title: String, content: String, date: Date, folder: JournalFolder? = nil) {
        self.title = title
        self.content = content
        self.date = date
        self.folder = folder
    }
}

extension JournalFolder {
    static func allJournals(with journals: [Journal]) -> JournalFolder {
        let virtualFolder = JournalFolder(title: allJournalsTitle, journals: journals)
        return virtualFolder
    }

    static let allJournalsTitle = "All Journals"
}

