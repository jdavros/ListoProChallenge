//
//  Character.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let imageURL: String

    private enum CodingKeys: String, CodingKey {
        case id, name, status
        case imageURL = "image"
    }
}
