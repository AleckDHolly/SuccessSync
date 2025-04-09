//
//  EditDreamView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-09.
//

import SwiftUI
import PhotosUI
import SwiftData

struct EditDreamView: View {
    @State private var selected: PhotosPickerItem?
    @State var dream: String = ""
    @FocusState private var isFocused: Bool
    @State var image: UIImage?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @State var asset: Asset
    
    var body: some View {
        VStack {
            TextField("Edit your dream here..", text: $dream)
                .focused($isFocused)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 3)
                )
                .padding()
            
            PhotosPicker(selection: $selected, matching: .images) {
                Text("Edit the image of your dream..")
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            .onChange(of: selected, initial: false) { oldValue, newValue in
                Task(priority: .background) {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        image = UIImage(data: data)
                    }
                }
            }
            .buttonStyle(.plain)
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } else {
                EmptyView()
            }
            
            Spacer()
            
            Button {
                if let image, !dream.isEmpty {
                    asset.title = dream
                    asset.image = image
                    try? context.save()
                }
                dismiss()
            } label: {
                Text("Edit Dream")
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
    @Previewable @Query var assets: [Asset]
    EditDreamView(asset: assets[0])
}
