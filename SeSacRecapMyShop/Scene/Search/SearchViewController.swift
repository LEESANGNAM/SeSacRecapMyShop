//
//  SearchViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit


class SearchViewcontroller: BaseViewController {
    let mainView = SearchView()
    let sortTypeList = SearchSortType.allCases
    var productList: [Item] = []
    var page = 1 // 페이지 저장용
    var searchText = "" //검색어 저장용
    var sortType: SearchSortType = .sim // 정렬용 변수
    var selectButton: UIButton? // 선택된 버튼 넣을 변수
    let repository = LikeRepository()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    override func setUpView() {
        super.setUpView()
        title = "상품 검색"
        let backbutton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backbutton
        for (index, button) in mainView.sortButtons.enumerated(){
            button.tag = index
            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        }
    }
    override func setConstraints() {
    }
    override func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.searchBar.delegate = self
    }
    
    @objc func sortButtonTapped(_ sender: UIButton){
//        guard !searchText.isEmpty else {
//            print("실시간 검색x 엔터키로검색안해서 검색내용이없음 못클릭함")
//            return
//        }
        do {
            let _ = try checkVaildation(text: searchText)
            let index = sender.tag
            let buttonTappedType = sortTypeList[index]
            let selectSortButton = mainView.sortButtons[index]
            
            selectButton?.defaultSortButtonStyle()
            sender.selectSortButtonStyle()  // 선택된 버튼의 배경을 라벨컬러, 라벨을 배경컬러로 반전 시켜준다.
            
            selectButton = selectSortButton
            sortType = buttonTappedType // 버튼 클릭하면 정렬 타입 변경
            
            productList.removeAll()       //리스트 지우고 바뀐 타입으로 요청
            page = 1
            callRequest(type: sortType, page: page, text: searchText){
                self.mainView.collectionView.reloadData()
                self.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }catch{
            switch error {
            case ValidationError.emptyString: showAlert(text: ValidationError.emptyString.returnString)
            default: print("error")
            }
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton){
        print("button Tapped")
        let product = productList[sender.tag]
        
        if let filterLikeProduct = repository.fetchFilter(item: product).first{
            repository.removeItem(filterLikeProduct)
            print("삭제완료")
        } else {
            let likeprodut = LikeProduct(item: product)
            repository.createItem(likeprodut)
            print("추가완료")
        }
        mainView.collectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
    }
    func checkVaildation(text: String) throws -> Bool {
        guard !(text.removeSpace().isEmpty) else{
            print("빈값")
            throw ValidationError.emptyString
        }
        return true
    }
}
//MARK: - APICallRequest
extension SearchViewcontroller {
    func callRequest(type: SearchSortType, page: Int, text : String, completion: (() -> Void)? = nil){
        APIService.shared.callRequest(type: type, query: text, page: page) { (data: ShopInfo) in
            //            print(data.items)
            if data.items.isEmpty{
                self.showAlert(text:ValidationError.emptyData.returnString)
            }
            self.productList += data.items
            for element in data.items{
                print("------------------------------------")
                print(element)
            }
            self.mainView.collectionView.reloadData()
            completion?()
        }
    }
}
//MARK: - SearchBar
extension SearchViewcontroller: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            print("값이 없음")
            return
        }
        do {
            let _ = try checkVaildation(text: text)
            page = 1
            searchText = text
            sortType = .sim // 검색 기본값 정확도로 검색
            
            selectButton?.defaultSortButtonStyle() // 기존 선택된 버튼 있으면 선택해제스타일
            
            selectButton = mainView.sortButtons[sortType.rawValue] // 정확도 버튼
            selectButton?.selectSortButtonStyle()
            
            productList.removeAll()
            searchBar.resignFirstResponder()
            callRequest(type: sortType, page: page, text: searchText)
            
        }catch{
            switch error{
            case ValidationError.emptyString: print(ValidationError.emptyString.returnString)
            default: print("Error")
            }
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.text = ""
        searchText = ""
        productList.removeAll()
        selectButton?.defaultSortButtonStyle()
        searchBar.resignFirstResponder()
        mainView.collectionView.reloadData()
    }
}

extension SearchViewcontroller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoColletionViewCell.identifier, for: indexPath) as! ProductInfoColletionViewCell
        if indexPath.row < productList.count {
            // 유효한 인덱스에서 항목을 가져오는 코드
            let item = productList[indexPath.row]
            cell.setUpCellUI(item: item)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = productList[indexPath.row]
        let vc = DetailViewController()
        vc.product = item
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewcontroller: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            if productList.count - 2 == indexPath.row && page < 1000{ // page(start)아이템위치 30개이후 스타트는 31번째 아이템 1000까지 가능
                page += 30
                callRequest(type: sortType, page: page, text: searchText)
            }
        }
    }
}
