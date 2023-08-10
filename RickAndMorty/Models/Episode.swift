//
//  Episodes.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 10/08/23.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "episode"
        case name
    }
}
