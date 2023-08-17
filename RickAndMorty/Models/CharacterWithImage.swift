//
//  CharacterWithImage.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 01/08/23.
//

import Foundation
import SwiftUI
import OSLog

enum ModelCreation: Error {
    case conversionError
}

struct CharacterWithImage: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: ExtraInfo
    let location: ExtraInfo
    let image: Image?
    let episodesURLs: [String]
    var episodes: [Episode]

    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: ExtraInfo,
        location: ExtraInfo,
        image: Image?,
        episodesURLs: [String],
        episodes: [Episode]
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image ?? Image.characterPlaceholder
        self.episodesURLs = episodesURLs
        self.episodes = episodes
    }

    init(entity: CharacterEntity) throws {

        guard let id = entity.value(forKey: "id") as? Int,
              let name = entity.value(forKey: "name") as? String,
              let status = entity.value(forKey: "status") as? String,
              let species = entity.value(forKey: "species") as? String,
              let type = entity.value(forKey: "type") as? String,
              let gender = entity.value(forKey: "gender") as? String,
              let origin = try ExtraInfo(entity: entity.origin),
              let location = try ExtraInfo(entity: entity.location),
              let episodes = entity.episodes?.allObjects as? [Episode]
        else {
            Logger.database.error("CoreData: Entity to Model conversion failed.\n\(ModelCreation.conversionError)")
            throw ModelCreation.conversionError
        }
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = Image.characterPlaceholder
        self.episodesURLs = []
        self.episodes = episodes
    }
}
