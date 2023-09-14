//
//  APIService.swift
//  SeSacRecapMyShop
//
//  Created by 이상남 on 2023/09/09.
//

import Foundation
import Alamofire

final class APIService {
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
            "display": 102, //요청 갯수
            "start": page, // 페이지
            "sort": type.requstParam //정렬 방법
        ]
        print("--------------------url",url,"------------sort",type.requstParam,"---------page",page)
        AF.request(url, method: .get, parameters: parameters, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400:
                            // 400 Bad Request 상태 코드 처리
                            print("잘못된오류\(error)")
                        case 404:
                            // 403 Forbidden 상태 코드 처리
                            print("링크오류\(error)")
                        case 500:
                            // 403 Forbidden 상태 코드 처리
                            print("시스템오류\(error)")
                        default:
                            print("Error with status code: \(statusCode)")
                        }
                    } else {
                        print(error)
                    }
                }
            }
    }
}

extension APIService {
    static let baseURL = "https://openapi.naver.com/v1/search/shop.json?"
}
