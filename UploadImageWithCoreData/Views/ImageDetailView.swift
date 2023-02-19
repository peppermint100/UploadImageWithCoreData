//
//  ImageDetailView.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/18.
//

import SwiftUI

struct ImageDetailView: View {
    var image: ImageDataModel
    var onDelete: () -> Void
    let container = CoreDataManager.shared.persistentContainer
    
    var body: some View {
        Image(uiImage: image.image)
            .resizable()
            .scaledToFit()
        
        Button("Delete") {
            onDelete()
        }
    }
}
