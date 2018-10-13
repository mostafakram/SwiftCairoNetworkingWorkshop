//
//  TimeLine.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/12/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import Foundation

typealias TimeLines = [TimeLine]

struct TimeLine: Codable {
    let date, text, image: String
    let user: User
    let id: Int
}

struct User: Codable {
}

