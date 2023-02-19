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
      
      /*
       deliveryMode를 .highQuality로 하고 싶다면 isSynchronous옵션을 켜주어야 한다.
       기본적으로 PHImageRequest는 고품질 이미지를 불러오는 동안 저품질 이미지를 보여주는데,
       이는 비동기적으로 작동하기 때문에 동기적으로 사용하겠다고 명시해야 한다.
       */
    option.isSynchronous = true
    option.deliveryMode = .highQualityFormat
      
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
