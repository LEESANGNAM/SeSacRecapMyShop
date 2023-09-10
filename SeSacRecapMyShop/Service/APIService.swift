//
//  APIService.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private init() { }
    
    func callRequest<T: Codable>(type: SearchSortType,query: String,page: Int, completionHandler: @escaping (T) -> ()) {
//    https://openapi.naver.com/v1/search/shop.json?query=캠핑카&display=30&start=1&sort=sim
        let url = APIService.baseURL
//        "query=\(query)&display=30&start=\(page)&sort=\(type.requstParam)"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": APIKey.ClientID,
                "X-Naver-Client-Secret":APIKey.ClientSecret
            ]
            let parameters: Parameters = [
                "query": query, //검색어
                "display": 30, //요청 갯수
                "start": page, // 페이지
                "sort": type.requstParam //정렬 방법 
            ]
        print("--------------------url",url,"------------sort",type.requstParam)
            AF.request(url, method: .get, parameters: parameters, headers: header).validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completionHandler(value)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
}

extension APIService {
    static let baseURL = "https://openapi.naver.com/v1/search/shop.json?"
}
