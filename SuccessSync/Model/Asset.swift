//
//  Asset.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Asset {
    var id = UUID()
    var title: String
    var imageData: Data
    var createdAt: Date
    
    init(title: String, image: UIImage) {
        self.title = title
        self.imageData = image.pngData()!
        self.createdAt = Date()
    }
    
    var image: UIImage {
        get {
            UIImage(data: imageData)!
        }
        set {
            let newImage = newValue
            self.imageData = newImage.jpegData(compressionQuality: 1.0)!
        }
    }
}

