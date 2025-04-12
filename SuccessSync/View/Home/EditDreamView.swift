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
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Edit your dream here..", text: $dream)
                    .focused($isFocused)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary, lineWidth: 1.5)
                    )
                    .padding()
                
                PhotosPicker(selection: $selected, matching: .images) {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
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
                
                Spacer()
                
                HStack {
                    Button {
                        showAlert = true
                    } label: {
                        Text("Delete Dream")
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                    
                    
                    Button {
                        if let image, !dream.isEmpty {
                            asset.title = dream
                            asset.imageData = image.pngData()!
                            try? context.save()
                        }
                        dismiss()
                    } label: {
                        Text("Edit Dream")
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.primary)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
            }
            .alert("Are you sure?", isPresented: $showAlert) {
                Button("No", role: .cancel) {
                    
                }
                
                Button("Yes", role: .destructive) {
                    context.delete(asset)
                    dismiss()
                }
            } message: {
                Text("\"\(asset.title)\" along with its picture will be deleted.")
            }
        }
    }
}

#Preview {
    let asset = Asset(title: "Car", image: UIImage(resource: .car))
    EditDreamView(dream: asset.title, image: asset.image, asset: asset)
}
