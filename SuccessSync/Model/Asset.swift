//
//  Asset.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import Foundation


struct Asset: Identifiable {
    let id = UUID()
    let title: String
}

let allAssets: [Asset] = [
    Asset(title: "Yacht"),
    Asset(title: "Private Jet"),
    Asset(title: "Baddie Wife")
]
