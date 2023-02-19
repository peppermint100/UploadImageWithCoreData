//
//  PhotoLibraryPreviewViewModel.swift
//  UploadImageWithCoreData
//
//  Created by peppermint100 on 2023/02/19.
//

import Foundation
import Photos
import UIKit

class PhotoLibraryPreviewViewModel: ObservableObject {
    
    @Published var images = [UIImage]()
    
    init() {
        loadPhotos()
    }
    
    func loadPhotos() {
        let options = PHFetchOptions()
        options.fetchLimit = 10
        let allPhotos = PHAsset.fetchAssets(with: .image, options: options)
        allPhotos.enumerateObjects { (asset, index, stop) in
            self.images.append(asset.toUIImage())
        }
    }
}

extension PHAsset {
  func toUIImage() -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    manager.requestImage(for: self,
                            targetSize: CGSize(width: self.pixelWidth, height: self.pixelHeight),
                            contentMode: .aspectFit,
                            options: option,
                            resultHandler: {(result, info) -> Void in
      thumbnail = result!
    })
    return thumbnail
  }
}
