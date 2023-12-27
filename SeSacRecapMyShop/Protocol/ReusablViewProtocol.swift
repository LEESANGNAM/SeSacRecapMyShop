//
//  ReusablViewProtocol.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import UIKit

//protocol ReusablViewProtocol {
//    static var identifier: String { get }
//}
//
//extension UIViewController: ReusablViewProtocol {
//    static var identifier: String {
//        return String(describing: self)
//    }
//}
//extension UICollectionViewCell: ReusablViewProtocol {
//    static var identifier: String {
//        return String(describing: self)
//    }
//}

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
