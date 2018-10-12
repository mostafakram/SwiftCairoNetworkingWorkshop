//
//  NetworkManager.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/12/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private var completionHander: ((Codable?, Error? )-> Void)
    
    
    init(completion: @escaping ((Codable?, Error?) -> Void)) {
        self.completionHander = completion
    }
    
    
    func makeDataRequest<T: Codable>( _ request: DataRequest, type: T.Type) {
        request.responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(type, from: data)
                    self.completionHander(response, nil)
                } catch {
                    self.completionHander(nil, error)
                }
                
                break
            case .failure(let error):
                self.completionHander(nil, error)
                break
            }
        }
    }
    
    
    func getTimeLines() {
        makeDataRequest(Alamofire.request("https://nodeswiftcairo.herokuapp.com/api/timelines"), type: TimeLines.self)
    }
}
