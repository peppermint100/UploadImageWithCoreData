//
//  CoreDataManager.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/16.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Image")
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Unable to load PersistentContainer error: \(error)")
            }
        }
    }
}
