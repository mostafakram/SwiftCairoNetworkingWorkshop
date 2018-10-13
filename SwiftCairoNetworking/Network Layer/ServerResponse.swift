//
//  ServerResponse.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation

enum ServerResponse<T> {
    case success(T)
    case failure(Error)
}

