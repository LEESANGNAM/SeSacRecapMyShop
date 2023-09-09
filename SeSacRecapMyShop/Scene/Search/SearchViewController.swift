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
    var page = 1
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상품 검색"
//        callRequest()
    }
    override func setUpView() {
        super.setUpView()
    }
    
    override func setConstraints() {
    }
    override func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchBar.delegate = self
    }
}
//MARK: - APICallRequest
extension SearchViewcontroller {
    func callRequest(type: SearchSortType = .sim, page: Int, text : String){
        APIService.shared.callRequest(type: type, query: text, page: page) { (data: ShopInfo) in
            print(data.items)
            self.productList = data.items
            self.mainView.collectionView.reloadData()
        }
    }
}
//MARK: - SearchBar
extension SearchViewcontroller: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        productList.removeAll()
        guard let text = searchBar.text, !text.isEmpty else {  return }
        searchBar.resignFirstResponder()
        callRequest(page: page, text: text)
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
