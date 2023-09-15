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
            "display": 30, //요청 갯수
            "start": page, // 페이지
            "sort": type.requstParam //정렬 방법
        ]
        print("--------------------url",url,"------------sort",type.requstParam,"---------page",page)
        AF.request(url, method: .get, parameters: parameters, headers: header).validate(statusCode: 200...300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        let statysError = NetworkError(rawValue: statusCode)
                        switch statysError {
                        case .parameterError:
                            print("잘못된 파라미터 값 에러 : 파라미터값 확인 \(error)")
                        case .notFoundError:
                            print("API 링크오류 존재하지 않는 링크: 요청 URL 확인\(error)")
                        case .systemError:
                            print("시스템 에러\(error)")
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
