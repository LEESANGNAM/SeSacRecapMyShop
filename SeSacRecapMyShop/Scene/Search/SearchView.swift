//
//  SearchView.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit

class SearchView: BaseView {
    
    let searchSortButtonlist = SearchSortType.allCases
    var sortButtons: [UIButton] = []
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        view.backgroundImage = UIImage()
        return view
    }()
    let cancleButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor( .label , for: .normal)
        return button
    }()
    lazy var stackView = {
        let view = UIStackView(arrangedSubviews: sortButtons)
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .leading
        view.distribution = .fillProportionally
        return view
    }()
    func createSortButton(){
        for sortType in searchSortButtonlist {
              let button = SearchSortButton()
            button.setTitle(sortType.titleString, for: .normal)
            sortButtons.append(button)
        }
    }
    override func setUpView() {
        super.setUpView()
        addSubview(searchBar)
        addSubview(cancleButton)
        createSortButton()
        addSubview(stackView)
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        cancleButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(searchBar.snp.trailing).offset(10)
            make.height.equalTo(searchBar.snp.height)
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
        
    }
}
