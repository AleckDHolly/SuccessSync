//
//  DreamAsset.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import PhotosUI

struct DreamAsset: View {
    let title: String
    @State private var selected: PhotosPickerItem?
    @State private var picture: UIImage?
    
    var body: some View {
        VStack {
            Spacer()
            
            PhotosPicker(selection: $selected, matching: .images) {
                if let picture {
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFill()
                } else {
                    Text(title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .onChange(of: selected) { oldValue, newValue in
                Task(priority: .background) {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        picture = UIImage(data: data)
                    }
                }
            }
            .frame(height: 225)
            .buttonStyle(.plain)
            
            
            Spacer()
            
            Button {
                
            } label: {
                HStack {
                    Text("Price:")
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 75)
                .background(.ultraThinMaterial)
            }
            .buttonStyle(.plain)
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    DreamAsset(title: "Upload a picture of your dream house")
}
