//
//  DatabaseClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 13/08/23.
//

import Foundation
import Combine

protocol DatabaseClientProtocol {
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { get }

    func fetchSavedCharactersList() -> AnyPublisher<[CharacterWithImage], Never>
    func fetchSavedCharacterEpisodes(_ character: CharacterWithImage) -> AnyPublisher<[Episode], Never>
    func saveCharacterRecords(_ character: CharacterWithImage)
}

enum DatabaseType {
    case coredata
    case realm
}

final class DatabaseClient: DatabaseClientProtocol {
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { client.savedCharactersPublisher }

    var client: DatabaseClientProtocol

    init(with type: DatabaseType) {
        switch type {
        case .coredata:
            client = CoreDataClient()
        case .realm:
            #warning("Needs implementation")
            client = RealmClient()
        }
    }

    func fetchSavedCharactersList() -> AnyPublisher<[CharacterWithImage], Never> {
        client.fetchSavedCharactersList()
    }

    func fetchSavedCharacterEpisodes(_ character: CharacterWithImage) -> AnyPublisher<[Episode], Never> {
        client.fetchSavedCharacterEpisodes(character)
    }

    func saveCharacterRecords(_ character: CharacterWithImage) {
        client.saveCharacterRecords(character)
    }
}
