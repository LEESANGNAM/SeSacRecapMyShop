//
//  NetworkError.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/15.
//

import Foundation

enum NetworkError: Int {
   case parameterError = 400
   case notFoundError = 404
   case systemError = 500
}
