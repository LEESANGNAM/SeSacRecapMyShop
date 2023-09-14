//
//  VaildationError.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/13.
//

import Foundation

enum ValidationError: Error {
    case emptyString
    case emptyData
    var returnString: String {
        switch self {
        case .emptyString:
            return "공백만 있음 검색어를 입력해주세요"
        case .emptyData:
            return "검색 결과가 없습니다."
        }
    }
}
