//
//  TimeLineRouter.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation
import Alamofire

enum TimeLineRouter: URLRequestConvertible {
    
    case all

    var params: Parameters? {
        switch self {
        case .all:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .all:
            return "timelines"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .all:
            return .get
        }
    }
    
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
    
    
    var baseURL: String {
      return "https://nodeswiftcairo.herokuapp.com/api/"
    }
    
    var url: URL {
        var url = URL(string: baseURL)!
        url.appendPathComponent(path)
        return url
    }
    
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
    
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: params)
    }
}
