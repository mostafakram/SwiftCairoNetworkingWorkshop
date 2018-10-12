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
    
    private var completionHander: ((Data?, Error? )-> Void)
    
    
    init(completion: @escaping ((Data?, Error?) -> Void)) {
        self.completionHander = completion
    }
    
    
    func makeDataRequest( _ request: DataRequest) {
        request.responseData { (response) in
            switch response.result {
            case .success(let data):
                self.completionHander(data, nil)
                break
            case .failure(let error):
                self.completionHander(nil, error)
                break
            }
        }
    }
    
    
    func getTimeLines() {
        makeDataRequest(Alamofire.request("https://nodeswiftcairo.herokuapp.com/api/timelines"))
    }
}
