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
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상품 검색"
        callRequest()
    }
    override func setUpView() {
        super.setUpView()
    }
    
    override func setConstraints() {
    }
    override func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}
extension SearchViewcontroller {
    func callRequest(){
        APIService.shared.callRequest(type: .sim, query: "캠핑카", page: 1) { (data: ShopInfo) in
            print(data.items)
            self.productList = data.items
            self.mainView.collectionView.reloadData()
        }
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
