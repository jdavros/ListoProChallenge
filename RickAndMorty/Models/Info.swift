//
//  Info.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 30/07/23.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let nextPage: String?
    let previousPage: String?

    private enum CodingKeys: String, CodingKey {
        case count, pages
        case nextPage = "next"
        case previousPage = "prev"
    }
}
