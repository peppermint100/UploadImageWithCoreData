//
//  ImageDetailView.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/18.
//

import SwiftUI

struct ImageDetailView: View {
    var image: UIImage? = nil
    var onPressDeleteButton: () -> Void
    
    var body: some View {
        if image != nil {
            Image(uiImage: image!)
               .resizable()
               .scaledToFit()
            
            Button("Delete") {
                onPressDeleteButton()
            }
        }
    }
}
