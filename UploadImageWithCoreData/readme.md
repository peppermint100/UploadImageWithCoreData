# CoreData를 활용한 이미지 업로드
---

## 데이터 모델 생성
---
- 데이터 모델 사이드바에서 옵셔널 확인
- 데이터 모델 사이드바에서 Codegen을 `Manual/None`으로 설정하여 데이터 모델 파일을 직접 작성
- `Transformable`을 사용하여 `UIImage` 타입으로 저장


## CoreDataManager 생성
---
- 영속성을 전체적으로 관리해주는 CoreDataManager를 싱글톤으로 생성
- Image 엔티티를 영속성에 추가

## Transformer 생성
---
- UIImage 데이터를 SQLite에 넣을 수 있도록 데이터를 변환해주는 클래스 추가
- DataModel 사이드바에 Transformer 추가
- CoreDataManager에 DataModel과 Transformer를 연결해주는 코드 추가




