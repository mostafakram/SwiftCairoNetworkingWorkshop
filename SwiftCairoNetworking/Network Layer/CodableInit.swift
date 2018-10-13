//
//  CodableInit.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/13/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation

protocol CodableInit: Codable {
    init(data: Data) throws
}
extension CodableInit {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        // I'm using snake case strategy, also Codable.
        // again you can use your own decoding lib/strategy
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self = try decoder.decode(Self.self, from: data)
    }
}
