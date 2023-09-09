//
//  SearchViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit


class SearchViewcontroller: BaseViewController {
    let mainView = SearchView()
    var productList: [Item] = []
    var page = 1 // 페이지 저장용
    var searchText = "" //검색어 저장용
    var sortType: SearchSortType = .sim // 정렬용 변수
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상품 검색"
    }
    override func setUpView() {
        super.setUpView()
    }
    
    override func setConstraints() {
    }
    override func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.searchBar.delegate = self
    }
}
//MARK: - APICallRequest
extension SearchViewcontroller {
    func callRequest(type: SearchSortType, page: Int, text : String){
        APIService.shared.callRequest(type: type, query: text, page: page) { (data: ShopInfo) in
            print(data.items)
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
        productList.removeAll()
        searchBar.resignFirstResponder()
        callRequest(type: sortType, page: page, text: searchText)
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
