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

## CoreData에 데이터 추가
- CoreDataManager에 데이터 추가 메소드 생성
- CoreData의 저장, 삭제, 수정 메소드를 각 뷰모델로 옮기는 구조가 좋다 

## Grid를 통한 이미지 나열

## 

## 삽질
- `.xcdatamodel`과 `CoreDataManager`에 사용하는 모든 엔티티 이름을 통일 해야함




