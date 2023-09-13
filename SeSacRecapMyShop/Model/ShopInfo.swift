//
//  ShopInfo.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import Foundation

struct ShopInfo: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice,  mallName, productID: String
    
    var imageURL: URL? {
        return URL(string: image)
    }
    
    var removeHTMLTagTitle: String {
        return title.removeHTMLTag()
    }
    
    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, mallName
        case productID = "productId"
    }
}

