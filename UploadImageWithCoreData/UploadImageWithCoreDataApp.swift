//
//  UploadImageWithCoreDataApp.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/16.
//

import SwiftUI

@main
struct UploadImageWithCoreDataApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}
