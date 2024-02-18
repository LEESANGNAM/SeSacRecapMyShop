
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

<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/12d0743f-b97b-4e8c-ab8d-08ee8616b72d"  width="40%"/> 
<img src = "https://github.com/LEESANGNAM/SeSacRecapMyShop/assets/61412496/0577e4a9-937b-47a5-8500-24f90bfc5b9e"  width="40%"/>  
</p>

+ api호출 후 이미지를 보여주는 과정에서 이미지의 로딩이 지연되고 스크롤시 메모리가 많이 차지하는 문제가 생겼다.
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

### 정렬옵션변경 스크롤 최상단
+ 검색을 스크롤 하는 도중 정렬옵션을 변경 하는경우 데이터만 초기화 되고 스크롤은 유지가 되는 문제가 생겼다.
+ api  콜이 끝날때 스크롤을 top 으로 올려주도록해서 문제 해결

~~~ swift 
productList.removeAll()       //리스트 지우고 바뀐 타입으로 요청
page = 1
callRequest(type: sortType, page: page, text: searchText){
    self.mainView.collectionView.reloadData()
    self.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
}
~~~
### 키보드를 내리기 위해 탭 제스처추가 후 셀선택 안되는 문제
+ 키보드를 내리기위해 view에 UITapGestureRecognizer추가 후 컬렉션뷰 셀클릭이 안되는 문제가 생겼다.
+ tap.cancelsTouchesInView = false  로 변경하여 모든 터치를 뷰에서 전달받도록 변경했다.
~~~ swift 
private func keyboardDownViewTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDown))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
@objc private func keyboardDown(){
    view.endEditing(true)
}
~~~