//
//  HomeView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    VStack(alignment: .leading) {
                        Text("Quote of the day:")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("\"If you ain't locked in, you're locked out. Choose wisely.\"")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DreamAsset(title: "Upload a picture of your dream house")
                    
                    DreamAsset(title: "Upload a picture of your dream car")
                    
                    ForEach(allAssets) { asset in
                        DreamAsset(title: "Upload a picture of your dream \(asset.title)")
                    }
                    
                    
                }
                .padding()
                .toolbar {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .padding(.trailing)
                    }
                }
            }
            .navigationTitle("Lock In")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
