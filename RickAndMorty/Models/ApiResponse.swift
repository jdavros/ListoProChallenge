//
//  ApiResponse.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 30/07/23.
//

import Foundation

struct ApiResponse: Codable {
    let info: Info
    let results: [Character]
}
