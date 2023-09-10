//
//  UIButton+Extension.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/11.
//

import UIKit

extension UIButton {
    func selectSortButtonStyle(){
        backgroundColor = .label
        setTitleColor(.systemBackground, for: .normal)
    }
    func defaultSortButtonStyle(){
        backgroundColor = .systemBackground
        setTitleColor(.label, for: .normal)
    }
}
