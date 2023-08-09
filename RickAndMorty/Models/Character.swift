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
    let species: String
    let type: String?
    let gender: String
    let origin: ExtraInfo
    let location: ExtraInfo
    let imageURL: String
    let episodes: [String]

    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location
        case imageURL = "image"
        case episodes = "episode"
    }
}

struct ExtraInfo: Codable {
    let name: String
    let url: String?
}
