//
//  CoreDataManager.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/16.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        ValueTransformer.setValueTransformer(
            UIImageTransformer(),
            forName: NSValueTransformerName("UIImageTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "ImageDataModel")
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Unable to load PersistentContainer error: \(error)")
            }
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
            print("date save!")
        } catch {
            print("CoreData 저장에 실패했습니다.")
        }
    }
    
    func addImage(image: UIImage) {
        let imageDataModel = ImageDataModel(context: persistentContainer.viewContext)
        imageDataModel.id = UUID()
        imageDataModel.createdAt = Date()
        imageDataModel.image = image
        save()
    }
}
