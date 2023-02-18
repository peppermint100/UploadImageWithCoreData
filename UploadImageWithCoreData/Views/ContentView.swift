//
//  ContentView.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/16.
//

import SwiftUI
import PhotosUI
import UIKit
import CoreData

struct ContentView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    @FetchRequest(
        sortDescriptors:
            [SortDescriptor(\.createdAt, order: .reverse)]) var images: FetchedResults<ImageDataModel>
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
                     ForEach(images) { image in
                         Image(uiImage: image.image!)
                             .resizable()
                             .frame(width: 150, height: 150)
                     }
                }
             }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            CoreDataManager.shared.addImage(image: UIImage(data: data)!)
                        }
                    }
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
