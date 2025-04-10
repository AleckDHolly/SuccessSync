//
//  DreamAsset.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import PhotosUI

struct DreamAsset: View {
    let asset: Asset
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                Image(uiImage: asset.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: geo.size.width)
                        .clipped()
            }
            
            Text(asset.title.capitalized)
                .font(.custom("Tangerine-Bold", size: 40, relativeTo: .largeTitle))
                .italic()
                .underline()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThickMaterial.opacity(0.75))
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    let asset = Asset(title: "House", image: UIImage(resource: .house))
    DreamAsset(asset: asset)
}
