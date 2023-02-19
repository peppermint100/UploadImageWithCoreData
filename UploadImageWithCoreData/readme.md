# CoreData를 활용한 이미지 업로드
---

## CoreData
---

### Entity
- 데이터 모델 사이드바에서 Codegen을 `Manual/None`으로 설정하여 데이터 모델 파일을 직접 작성
- 상단바에서 Editor -> Create NSObject ... 를 사용하면 해당 엔티티에 맞는 데이터 모델 파일 생성 가능
- 영속성을 전체적으로 관리해주는 CoreDataManager를 싱글톤으로 생성

### Transformer 
- `Transformable`을 사용하여 CodeData 파일 저장 시 `UIImage` 타입 사용 가능
- UIImage 데이터를 SQLite에 넣을 수 있도록 데이터를 변환해주는 클래스 추가

```swift
class UIImageTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            return image
        } catch {
            return nil
        }
    }
}

```

각 밸류를 서로 바꿔주는 Transformer를 생성 후에

- DataModel 사이드바에 Transformer 추가
- CoreDataManager에 DataModel과 Transformer를 연결해주는 코드 추가

```swift
ValueTransformer.setValueTransformer(
        UIImageTransformer(),
        forName: NSValueTransformerName("UIImageTransformer"))
```

## 폴더 구조
```
CoreData: Entity, CodeDataManager
View: 화면 단위
ViewModel: 뷰 내에 존재하는 상태 값과 그 상태값을 변환 시키는 비즈니스 로직
```

## 삽질
- `.xcdatamodel`과 `CoreDataManager`에 사용하는 모든 엔티티 이름을 통일 해야함
- PHAsset을 UIImage로 바꿀 때 deliveryMode를 통해 사진의 품질을 지정할 수 있다. 

```swift
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
```
품질을 저화질에서 바꾸고 싶다면 `isSynchronous` 옵션도 활성화 해주어야 한다.

## 미해결
- 사진 접근 권한 받은 후 최초 실행시에는 이미 뷰의 라이프사이클이 지나버려서 로컬 파일을 가져오지 않음. []
