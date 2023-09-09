//
//  LikeViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit

class LikeViewController: BaseViewController {
    let mainView = LikeView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "좋아요 목록"
    }
    override func setUpView() {
        super.setUpView()
    }
    override func setConstraints() {
    }
    
    override func setDelegate() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
}
extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoColletionViewCell.identifier, for: indexPath) as! ProductInfoColletionViewCell
        cell.backgroundColor = .blue
//        let item = productList[indexPath.row]
//        cell.setUpCellUI(item: item)
        return cell
    }
}
