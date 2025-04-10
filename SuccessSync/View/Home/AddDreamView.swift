//
//  EditDreamsView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-07.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddDreamView: View {
    @State private var selected: PhotosPickerItem?
    @State var dream: String = ""
    @FocusState private var isFocused: Bool
    @State var image: UIImage?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            TextField("Add a dream here..", text: $dream)
                .focused($isFocused)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 3)
                )
                .padding()
            
            PhotosPicker(selection: $selected, matching: .images) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Add a picture")
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            }
            .onChange(of: selected, initial: false) { oldValue, newValue in
                Task(priority: .background) {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        image = UIImage(data: data)
                    }
                }
            }
            .buttonStyle(.plain)
            
            Button {
                if let image, !dream.isEmpty {
                    let asset = Asset(title: dream, image: image)
                    context.insert(asset)
                    try? context.save()
                }
                dismiss()
            } label: {
                Text("Save Dream")
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AddDreamView()
}
