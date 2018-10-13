//
//  TimeLineRouter.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation
import Alamofire

enum TimeLineRouter: URLRequestBuilder {
    
    case all

    var paramaters: Parameters? {
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
    
}
