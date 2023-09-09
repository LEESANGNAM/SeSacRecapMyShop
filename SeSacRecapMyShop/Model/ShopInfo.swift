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
    let lprice, hprice, mallName, productID: String
    let productType: String
//    let brand, maker: Brand
//    let category1: Category1
//    let category2: Category2
//    let category3: Category3
//    let category4: String
    
    var imageURL: URL? {
        return URL(string: image)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName
        case productID = "productId"
        case productType
//        , brand, maker, category1, category2, category3, category4
    }
}

//enum Brand: String, Codable {
//    case empty = ""
//    case unknown = "UNKNOWN"
//    case 크록스 = "크록스"
//}
//
//enum Category1: String, Codable {
//    case 출산육아 = "출산/육아"
//    case 패션잡화 = "패션잡화"
//}
//
//enum Category2: String, Codable {
//    case 남성신발 = "남성신발"
//    case 여성신발 = "여성신발"
//    case 유아동잡화 = "유아동잡화"
//}
//
//enum Category3: String, Codable {
//    case 기능화 = "기능화"
//    case 샌들 = "샌들"
//    case 슬리퍼 = "슬리퍼"
//    case 슬립온 = "슬립온"
//    case 신발 = "신발"
//}
