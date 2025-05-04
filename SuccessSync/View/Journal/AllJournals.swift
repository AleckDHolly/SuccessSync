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
    var journals: [Journal] { journalFolder.journals }
    var folderTitle: String { journalFolder.title }
    
    @Query private var journalFolders: [JournalFolder]

    var body: some View {
        NavigationStack {
            Group {
                if journals.isEmpty {
                    ContentUnavailableView("No journals yet", systemImage: "figure.mind.and.body.circle", description: Text("Add your first journal entry to have a better peace of mind."))
                } else {
                    List {
                        ForEach(journals.sorted { $0.date > $1.date }) { journal in
                            NavigationLink {
                                SingleJournal(journal: journal, journalFolder: journalFolder)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(journal.title.isEmpty ? journal.date.formatted(date: .abbreviated, time: .omitted) : journal.title)
                                        .font(.title2)
                                        .bold()
                                    Text(journal.content)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    Text(journal.date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .contextMenu {
                                Menu("Move to folder") {
                                    ForEach(journalFolders) { folder in
                                        Button(folder.title) {
                                            if folder.title != JournalFolder.allJournalsTitle {
                                                folder.journals.append(journal)
                                            }
                                        }
                                    }

                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle(folderTitle)
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
            context.delete(journals[index])
        }
    }
}



#Preview {
    AllJournals(journalFolder: JournalFolder(title: "Folder Title", journals: [Journal(title: "Title", content: "Content", date: Date())]) )
}
