
# MyShop

### 실행화면
<p>
<!-- [상품검색_좋아요] -->
<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/e29f157a-0642-4d70-8b27-b0290be12a98" width="22%"/>  
<!-- [상품상세_웹뷰] -->
<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/ed2a6dad-53b8-4a71-9d38-0fd6488be524" width="22%"/>  
<!-- [좋아요리스트_검색] -->
<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/917712ff-5169-4b51-bd56-6a81c9ccb018" width="22%"/>  
<!-- [좋아요리스트_없을때] -->
<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/6e2e5327-91b3-45f8-b8ba-518ed5e8ef50" width="22%"/>  

</p>

### 간단소개
네이버 쇼핑 상품데이터를 제공하고 좋아요 기능을 통해 관리 할 수 있는 앱

## 개발기간
+ 개인프로젝트
+ 2023.09.08 ~ 2023.09.11
## 최소타겟
+ iOS 13.0

## 기술스택
+ MVC, UIKit
+ SnapKit, AutoLayout
+ Kingfisher,Alamofire
+ Realm
## 기능소개
+ 네이버 쇼핑 검색 기능
+ 상품 좋아요기능
+ 좋아요 검색기능
+ 상품 상세 정보확인(웹뷰)

## 트러블슈팅

### 이미지 다운샘플링
<p>

<img src = "hhttps://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/dda893de-0492-453e-8751-5898ba8f3c4f"  width="40%"/> 
<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/0577e4a9-937b-47a5-8500-24f90bfc5b9e"  width="40%"/>  
</p>

+ api호출 후 이미지를 보여주는 과정에서 이미지의 로딩이 지연되고 스크롤시 메모리가 많이 차지하는 문제 발견
+ Kingfisher의 이미지 캐싱과 다운샘플링을 이용해 메모리 사용 최소화, 이미지 로딩되는 동안 인디케이터 사용
~~~ swift
if let imageURL = item.imageURL{
            let imagesize = posterImageView.bounds.size //이미지뷰 사이즈
            let dowunSizeProcessor = DownsamplingImageProcessor(size: imagesize) //사이즈만큼 줄이기
            posterImageView.kf.indicatorType = .activity //인디케이터
            posterImageView.kf.setImage(
                with: imageURL,
                options: [
                    .processor(dowunSizeProcessor),
                    .cacheOriginalImage // 큰사이즈 이미지 캐싱
                         ]
                )
        }
~~~

### 필터옵션변경 스크롤 최상단

### 키보드를 내리기 위해 탭 제스처추가 후 셀선택 안되는 문제
