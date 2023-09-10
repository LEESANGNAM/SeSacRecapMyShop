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
        title = "상품 검색"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    override func setUpView() {
        super.setUpView()
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
        guard let text = mainView.searchBar.text, !text.isEmpty else {
            print("선택 안되게 할거임, 색상타입도 안바꿔줄거임")
            return
        }
        let index = sender.tag
        let buttonTappedType = sortTypeList[index]
        let selectSortButton = mainView.sortButtons[index]
        
        if let selectButton {
            selectButton.defaultSortButtonStyle()
        }
        sender.selectSortButtonStyle()  // 선택된 버튼의 배경을 라벨컬러, 라벨을 배경컬러로 반전 시켜준다.
        selectButton = selectSortButton
        sortType = buttonTappedType // 버튼 클릭하면 정렬 타입 변경
        
        
        productList.removeAll()       //리스트 지우고 바뀐 타입으로 요청
        callRequest(type: sortType, page: page, text: searchText)
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
    
}
//MARK: - APICallRequest
extension SearchViewcontroller {
    func callRequest(type: SearchSortType, page: Int, text : String){
        APIService.shared.callRequest(type: type, query: text, page: page) { (data: ShopInfo) in
            //            print(data.items)
            self.productList += data.items
            self.mainView.collectionView.reloadData()
        }
    }
}
//MARK: - SearchBar
extension SearchViewcontroller: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {  return }
        page = 1
        searchText = text
        sortType = .sim // 검색 기본값 정확도로 검색
        if let firstButton = mainView.sortButtons.first {
                firstButton.selectSortButtonStyle()
                selectButton = firstButton
            }
        productList.removeAll()
        searchBar.resignFirstResponder()
        callRequest(type: sortType, page: page, text: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.text = ""
        searchText = ""
        productList.removeAll()
        mainView.collectionView.reloadData()
    }
}

extension SearchViewcontroller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoColletionViewCell.identifier, for: indexPath) as! ProductInfoColletionViewCell
        let item = productList[indexPath.row]
        cell.setUpCellUI(item: item)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return cell
    }
}

extension SearchViewcontroller: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            if productList.count - 10 == indexPath.row && page < 100{ // page 1000까지 가능 일단 100까지
                page += 1
                callRequest(type: sortType, page: page, text: searchText)
            }
        }
    }
}
