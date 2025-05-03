//
//  SingleJournal.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-02.
//

import SwiftUI

struct SingleJournal: View {
    @State var journal: Journal?
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
                                    if newValue.isEmpty {
                                        journal?.title = dateString
                                    } else {
                                        journal?.title = newValue
                                    }
                                } else {
                                    title = newValue
                                }
                            }),
                          axis: .vertical)
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
            .navigationTitle(journal?.title ?? dateString)
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
}

#Preview {
    SingleJournal()
}
