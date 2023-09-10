//
//  LikeProduct.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/10.
//

import Foundation
import RealmSwift

class LikeProduct: Object{
    @Persisted(primaryKey: true) var productID: String
    @Persisted var mallName : String
    @Persisted var title : String
    @Persisted var lprice : String
    @Persisted var image : String
    @Persisted var link : String
    
    convenience init(item: Item) {
        self.init()
        self.productID = item.productID
        self.mallName = item.mallName
        self.title = item.title.removeHTMLTag()
        self.lprice = item.lprice
        self.image = item.image
        self.link = item.link
    }
}
