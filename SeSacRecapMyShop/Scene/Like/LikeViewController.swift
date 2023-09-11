//
//  LikeViewController.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit
import RealmSwift

class LikeViewController: BaseViewController {
    let mainView = LikeView()
    let repository = LikeRepository()
    var likeList: Results<LikeProduct>!
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "좋아요 목록"
        likeList = repository.fetch()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
    }
    override func setUpView() {
        super.setUpView()
    }
    override func setConstraints() {
    }
    
    override func setDelegate() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.searchBar.delegate = self
    }
    @objc func likeButtonTapped(_ sender: UIButton){
        print("button Tapped")
        let likeproduct = likeList[sender.tag]
        repository.removeItem(likeproduct)
        mainView.collectionView.reloadData()
    }
}
extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInfoColletionViewCell.identifier, for: indexPath) as! ProductInfoColletionViewCell
        let item = likeList[indexPath.row]
        cell.setUpCellUI(likeProduct: item)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = likeList[indexPath.row]
        let vc = DetailViewController()
        vc.product = item.changeToItem()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension LikeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        likeList = repository.fetch()
        searchBar.resignFirstResponder()
        mainView.collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            likeList = repository.fetch()
            mainView.collectionView.reloadData()
            return
        }
        likeList = repository.fetchFilterTitle(title: searchText)
        mainView.collectionView.reloadData()
    }
}
