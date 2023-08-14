//
//  DatabaseClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 13/08/23.
//

import Foundation

protocol DatabaseClientProtocol {
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { get }

    func fetchAllRecords()
    func saveCharacterRecords(_ character: Character)
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

    func fetchAllRecords() {
        client.fetchAllRecords()
    }

    func saveCharacterRecords(_ character: Character) {
        client.saveCharacterRecords(character)
    }
}
