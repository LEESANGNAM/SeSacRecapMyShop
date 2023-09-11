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
    @Persisted var createTime = Date() //생성 시간
    
    var imageURL : URL? {
        return URL(string: image)
    }
    convenience init(item: Item) {
        self.init()
        self.productID = item.productID
        self.mallName = item.mallName
        self.title = item.title.removeHTMLTag()
        self.lprice = item.lprice
        self.image = item.image
        self.link = item.link
    }
    func changeToItem() -> Item {
        return Item(title: self.title,
                    link: self.link,
                    image: self.image,
                    lprice: self.lprice,
                    mallName: self.mallName,
                    productID: self.productID)
    }
}
