//
//  JournalFolders.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-03.
//

import SwiftUI
import SwiftData

struct JournalFolders: View {
    @Query(sort: \JournalFolder.title, order: .forward) private var journalFolders: [JournalFolder]
    @Query(sort: \Journal.date, order: .reverse)
    private var allJournals: [Journal]

    
    @Environment(\.modelContext) private var context
    @State private var addJournalTitle: Bool = false
    @State private var newJournalFolderTitle: String = ""
    
    @State private var folderToRename: JournalFolder?
    @State private var newNameForFolder: String = ""
    
    var allJournalsFolder: JournalFolder {
        let all = JournalFolder(title: "All Journals", journals: allJournals)
        return all
    }

    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("All Journals") {
                    AllJournals(journalFolder: allJournalsFolder)
                }
                
                ForEach(journalFolders) { journalFolder in
                    NavigationLink {
                        AllJournals(journalFolder: journalFolder)
                    } label: {
                        Text(journalFolder.title)
                    }
                    .contextMenu {
                        Button("Rename") {
                            folderToRename = journalFolder
                            newNameForFolder = journalFolder.title
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Journal Folders")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Add your folder's title", isPresented: $addJournalTitle) {
                TextField("Add a new journal folder", text: $newJournalFolderTitle)
                    .onSubmit {
                        addTitle()
                    }
                
                Button("Cancel", role: .cancel) {
                    newJournalFolderTitle = ""
                    addJournalTitle = false
                }
                Button("OK") {
                    addTitle()
                }
            }
            .alert("Rename Folder", isPresented: .constant(folderToRename != nil), actions: {
                TextField("Folder title", text: $newNameForFolder)
                Button("Cancel", role: .cancel) {
                    folderToRename = nil
                    newNameForFolder = ""
                }
                Button("Save") {
                    if let folder = folderToRename {
                        folder.title = newNameForFolder
                        folderToRename = nil
                        newNameForFolder = ""
                    }
                }
            })
            
            .toolbar {
                Button {
                    addJournalTitle = true
                } label: {
                    Image(systemName: "plus")
                        .padding(.trailing)
                }
            }
        }
    }
    
    func addTitle() {
        let journalFolder = JournalFolder(title: newJournalFolderTitle, journals: [])
        context.insert(journalFolder)
        newJournalFolderTitle = ""
        addJournalTitle = false
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let journalFolder = journalFolders[index]
            context.delete(journalFolder)  // Then delete from context
        }
    }
}


#Preview {
    JournalFolders()
}
