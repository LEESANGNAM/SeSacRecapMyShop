//
//  SearchViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit


class SearchViewcontroller: BaseViewController {
    let mainView = SearchView()
    var proTitle: String?
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상품 검색"
        APIService.shared.callRequest(type: .sim, query: "캠핑카", page: 1) { (data: ShopInfo) in
            print(data.items)
            self.proTitle = data.items[0].title
            self.mainView.collectionView.reloadData()
        }
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


extension SearchViewcontroller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoColletionViewCell.identifier, for: indexPath) as! ProductInfoColletionViewCell
        cell.backgroundColor = .systemGray
        if let proTitle {
            cell.titleNameLabel.text = proTitle
        }
        return cell
    }
    
    
}
