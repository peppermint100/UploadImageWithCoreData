//
//  ImageGridViewModel.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/18.
//

import Foundation
import UIKit
import CoreData

class ImageGridViewModel: ObservableObject {
    
    @Published var images = [ImageDataModel]()
    let container = CoreDataManager.shared.persistentContainer
    
    init() {
        fetchImages()
    }
    
    func fetchImages() {
        let request = NSFetchRequest<ImageDataModel>(entityName: "ImageDataModel")
        do {
            images = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func addImage(image: UIImage) {
        let imageDataModel = ImageDataModel(context: container.viewContext)
        imageDataModel.id = UUID()
        imageDataModel.createdAt = Date()
        imageDataModel.image = image
        images.append(imageDataModel)
        save()
    }
    
    func deleteImage(image: ImageDataModel) {
        if let index = images.firstIndex(of: image) {
            images.remove(at: index)
            container.viewContext.delete(image)
            save()
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
            print("date save!")
        } catch {
            print("CoreData 저장에 실패했습니다.")
        }
    }
}
