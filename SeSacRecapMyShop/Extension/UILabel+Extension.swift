//
//  UILabel+Extension.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit

extension UILabel{
    func setUpMallLabelStyle(){
        font = .systemFont(ofSize: 14)
        textColor = .systemGray3
    }
    func setUpTitleLabelStyle(){
        font = .systemFont(ofSize: 14)
        textColor = .label
    }
    func setUpPriceLabelStyle(){
        font = .boldSystemFont(ofSize: 20)
        textColor = .label
    }
}
