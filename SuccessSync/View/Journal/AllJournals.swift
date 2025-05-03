//
//  AllJournals.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import SwiftUI
import SwiftData

struct AllJournals: View {
    @Query(sort: \Journal.date, order: .reverse) private var journals: [Journal]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            Group {
                if journals.isEmpty {
                    ContentUnavailableView("Add your first journal entry!", systemImage: "figure.mind.and.body.circle", description: Text("In order to have a better peace of mind, please add your first journal entry."))
                } else {
                    List {
                        ForEach(journals) { journal in
                            Group {
                                NavigationLink {
                                    SingleJournal(journal: journal)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(journal.title)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        
                                        Text(journal.content)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        
                                        Text("Added/Updated on: \(journal.date.formatted(date: .abbreviated, time: .omitted))")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    SingleJournal()
                } label: {
                    Image(systemName: "plus")
                        .padding(.trailing)
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let journal = journals[index]
            context.delete(journal)
        }
    }
}

#Preview {
    AllJournals()
}
