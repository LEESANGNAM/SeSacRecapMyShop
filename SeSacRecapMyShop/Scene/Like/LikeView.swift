//
//  LikeView.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/10.
//
import UIKit

class LikeView: BaseView {
    
    let searchSortButtonlist = SearchSortType.allCases
    var sortButtons: [UIButton] = []
    let nodatalabel = {
       let view = UILabel()
        view.text = "상품검색에서 좋아요를 해보세요"
        return view
    }()
    lazy var nodataView = {
        let view = UIView()
        view.addSubview(nodatalabel)
        view.backgroundColor = .systemBackground
        return view
    }()
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        view.backgroundImage = UIImage()
        view.showsCancelButton = true
        if let cancelButton = view.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitleColor(.label, for: .normal)
            cancelButton.setTitle("취소", for: .normal)
        }
        return view
    }()
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(ProductInfoColletionViewCell.self, forCellWithReuseIdentifier: ProductInfoColletionViewCell.identifier)
        view.collectionViewLayout = setCollectionViewLayout()
        return view
    }()
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        // 전체 너비 가져와서 빼기
        let width = UIScreen.main.bounds.width - (spacing * 3)
        let itemSize = width / 2
        layout.itemSize = CGSize(width: itemSize, height: itemSize * 1.5)
        //컬렉션뷰 inset
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        // 최소 간격
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
    override func setUpView() {
        super.setUpView()
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(nodataView)
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(5)
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
        nodatalabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nodataView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
        
    }
}
