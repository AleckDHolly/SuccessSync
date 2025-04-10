//
//  HomeView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import PhotosUI
import SwiftData

struct HomeView: View {
    @State private var showingDreamSheet: Bool = false
    @State private var editDreamSheet: Bool = false
    @State private var asset: Asset?
    @Query(sort: \Asset.createdAt) private var assets: [Asset]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Quote of the day:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("\"If you ain't locked in, you're locked out. Choose wisely.\"")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                TabView {
                    ForEach(assets) { asset in
//                        Tab {
                            DreamAsset(asset: asset)
                                .frame(maxHeight: .infinity)
                                .onTapGesture {
                                    self.asset = asset
                                }
//                        }
                    }
                }
                .tabViewStyle(.page)
            }
            .padding()
            .toolbar {
                Button {
                    showingDreamSheet = true
                } label: {
                    Image(systemName: "plus")
                        .padding(.trailing)
                }
            }
            .navigationTitle("Lock In")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingDreamSheet) {
                AddDreamView()
                    .presentationDetents([.medium])
            }
            .sheet(item: $asset) { asset in
                EditDreamView(dream: asset.title, image: asset.image, asset: asset)
                    .presentationDetents([.medium])
            }
        }
    }
}


#Preview {
    HomeView()
}
