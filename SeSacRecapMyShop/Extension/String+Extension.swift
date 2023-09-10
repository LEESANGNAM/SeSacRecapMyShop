//
//  String+Extension.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/10.
//

import Foundation


extension String {
    func changeFormatPrice() -> String {
        if let price = Int(self){
            let numberFormat = NumberFormatter()
            numberFormat.numberStyle = .decimal
            if let changeString = numberFormat.string(from: NSNumber(value: price)){
                return changeString
            }
        }
        return self
    }
}
