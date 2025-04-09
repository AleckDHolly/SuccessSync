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
    @State var picture: UIImage?
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                if let picture {
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: geo.size.width)
                        .clipped()
                }
            }
            
            Text(title.capitalized)
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
    DreamAsset(title: "house", picture: .house)
}
