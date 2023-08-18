//
//  RealmClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Foundation
import CoreData
import Combine

final class RealmClient: DatabaseClientProtocol {
    @Published var savedCharacters: [CharacterEntity] = []
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { $savedCharacters }

    init() {

    }

    public func fetchSavedCharactersList() -> AnyPublisher<[CharacterWithImage], Never> {
        #warning("Needs implementation")
        return Just([])
            .eraseToAnyPublisher()
    }

    public func fetchSavedCharacterEpisodes(_ character: CharacterWithImage) -> AnyPublisher<[Episode], Never> {
        #warning("Needs implementation")
        return Just([])
            .eraseToAnyPublisher()
    }

    public func saveCharacterRecords(_ character: CharacterWithImage) {
        #warning("Needs implementation")
    }
}
