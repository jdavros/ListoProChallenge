//
//  Episodes.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 10/08/23.
//

import Foundation
import OSLog

struct Episode: Codable, Identifiable {
    let id: String
    let name: String
    let url: String
    let characters: [String]

    enum CodingKeys: String, CodingKey {
        case id = "episode"
        case name, url, characters
    }

    init(id: String, name: String, url: String, characters: [String]) {
        self.id = id
        self.name = name
        self.url = url
        self.characters = characters
    }

    init(entity: EpisodeEntity) throws {
        guard let id = entity.value(forKey: "id") as? String,
              let name = entity.value(forKey: "name") as? String,
              let url = entity.value(forKey: "url") as? String,
              let characters = entity.characters?.allObjects as? [Character]
        else {
            Logger.database.error("CoreData: Entity to Model conversion failed.\n\(ModelCreation.conversionError)")
            throw ModelCreation.conversionError
        }
        let charactersURLs = characters.map {
            Endpoints.getEndpointStringValue(with: .characterWithId($0.id))
        }

        self.id = id
        self.name = name
        self.url = url
        self.characters = charactersURLs
    }
}
