//
//  GitRepo.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Foundation

struct SearchResponse: Decodable {
    let items: [GitRepo]
}

struct GitRepo: Codable {
    let id: Int
    let name: String
}
