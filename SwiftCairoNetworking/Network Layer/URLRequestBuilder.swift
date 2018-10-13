//
//  URLRequestBuilder.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: APIRequestHandler, URLRequestConvertible {
    var mainURL: String { get }
    var paramaters: Parameters? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var urlRequest: URLRequest { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestBuilder {
    var mainURL: String {
        return "https://nodeswiftcairo.herokuapp.com/api/"
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var url: URL {
        var url = URL(string: mainURL)!
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
        return try encoding.encode(urlRequest, with: paramaters)
    }
    
}
