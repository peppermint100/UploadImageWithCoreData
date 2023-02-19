//
//  CoreDataManager.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/16.

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
}
