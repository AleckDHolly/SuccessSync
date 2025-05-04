//
//  AllJournals.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import SwiftUI
import SwiftData

struct AllJournals: View {
    @Bindable var journalFolder: JournalFolder
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            Group {
                if journalFolder.journals.isEmpty {
                    ContentUnavailableView("No journals yet", systemImage: "square.and.pencil", description: Text("Add your first journal."))
                } else {
                    List {
                        ForEach(journalFolder.journals.sorted { $0.date > $1.date }) { journal in
                            NavigationLink {
                                SingleJournal(journal: journal)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(journal.title)
                                        .font(.title3)
                                        .bold()
                                    Text(journal.content)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    Text(journal.date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle(journalFolder.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    SingleJournal(journalFolder: journalFolder)
                } label: {
                    Image(systemName: "plus")
                        .padding(.trailing)
                }
            }
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            context.delete(journalFolder.journals[index])
        }
    }
}



#Preview {
    AllJournals(journalFolder: JournalFolder(title: "Folder Title", journals: [Journal(title: "Title", content: "Content", date: Date())]) )
}
