//
//  NYTimesRouter.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire

enum NYTimesRouter: URLRequestConvertible {
    static let apiKey = "32534511931e4dc1b5627b6918ca0d6b"
    static let baseURLString = "https://api.nytimes.com/svc"
    
    case news([String: Any]?)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .news:
                return .get
            }
        }
        let params: ([String: Any]?) = {
            switch self {
            case .news(let newValue):
                return newValue
            }
        }()
        let url: URL = {
            let relativePath: String?
            switch self {
            case .news:
                relativePath = "/mostpopular/v2/emailed/7.json?api-key=" + NYTimesRouter.apiKey
            }
            var url = URL(string: NYTimesRouter.baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        let urlRequest: URLRequest = {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            
            let tokenApp = "defaultToken"
            urlRequest.addValue(tokenApp, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            return urlRequest
        }()
        let encoding: ParameterEncoding = {
            return URLEncoding.default
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}

