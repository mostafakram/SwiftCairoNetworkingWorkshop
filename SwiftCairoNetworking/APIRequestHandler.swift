//
//  APIRequestHandler.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation
import Alamofire

typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?


protocol APIRequestHandler: HandleAlamofireResponse {
    
}

extension APIRequestHandler where Self: URLRequestConvertible {
    
    func send<T: Codable> (_ decoder: T.Type, completion: CallResponse<T> ) {
        request(self).validate().responseData { (response) in
            self.handleResponse(response, completion: completion)
            }
    }
    
}
