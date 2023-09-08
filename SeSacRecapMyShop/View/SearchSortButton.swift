//
//  SearchSortButton.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit


class SearchSortButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
