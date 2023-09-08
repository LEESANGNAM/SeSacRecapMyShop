//
//  SearchSortType.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import Foundation

enum SearchSortType:Int, CaseIterable{
    case sim
    case date
    case asc
    case dsc
    
    var titleString: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .asc:
            return "오름차순"
        case .dsc:
            return "내림차순"
        }
    }
    var requstParam: String {
        switch self {
        case .sim:
            return "sim"
        case .date:
            return "date"
        case .asc:
            return "asc"
        case .dsc:
            return "dsc"
        }
    }
}
