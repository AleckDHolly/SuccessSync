//
//  SingleJournal.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import SwiftUI

struct SingleJournal: View {
    @State var journal: Journal?
    @State var journalFolder: JournalFolder?
    @State private var title: String = ""
    @State private var content: String = ""
    var dateString: String {
        Date().formatted(date: .abbreviated, time: .omitted)
    }
    @FocusState private var isContentFocused: Bool
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title for \(dateString)",
                          text: Binding(
                            get: {journal?.title ?? title },
                            set: { newValue in
                                if journal != nil {
                                    if !newValue.isEmpty {
                                        journal?.title = newValue
                                    } else {
                                        journal?.title = ""
                                    }
                                } else {
                                    title = newValue
                                }
                            }))
                    .font(.title)
                    .fontWeight(.semibold)
                    .submitLabel(.next)
                    .onSubmit {
                        isContentFocused = true
                    }
                
                TextEditor(text: Binding(
                    get: {journal?.content ?? content},
                    set: { newValue in
                        if journal != nil {
                            journal?.content = newValue
                        } else {
                            content = newValue
                        }
                        
                    }))
                    .focused($isContentFocused)
                    .font(.system(size: 20))
            }
            .onChange(of: journal?.title) { _, newValue in
                journal?.date = Date()
            }
            .onChange(of: journal?.content) { _, newValue in
                journal?.date = Date()
            }
            .padding()
            .navigationTitle(navBarTitle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if journal == nil {
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                        
                        let newJournal = Journal(
                            title: title.isEmpty ? dateString : title,
                            content: content,
                            date: Date()
                        )
                        
                        if journalFolder?.title != JournalFolder.allJournalsTitle {
                            journalFolder?.journals.append(newJournal)
                        }
                        context.insert(newJournal)
                        journal = newJournal
                    } label: {
                        Text("Save")
                            .padding(.trailing)
                    }
                }
            }
        }
    }
    
    func navBarTitle() -> String {
        if let journal {
            if journal.title.isEmpty {
                return dateString
            } else {
                return journal.title
            }
        } else {
            return dateString
        }
    }
}

#Preview {
    SingleJournal()
}
