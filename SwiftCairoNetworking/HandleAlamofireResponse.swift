//
//  HandleAlamofireResponse.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation
import Alamofire

protocol HandleAlamofireResponse {
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>)

}

extension HandleAlamofireResponse {
    func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: CallResponse<T>) {
        switch response.result {
        case .failure(let error):
            completion?(ServerResponse.failure(error))
        case .success(let value):
            do {
                let models = try JSONDecoder().decode(T.self, from: value)
                completion?(ServerResponse<T>.success(models))
            } catch {
                completion?(ServerResponse.failure(error))
            }
        }
    }

}
