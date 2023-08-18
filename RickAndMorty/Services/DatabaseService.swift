//
//  DatabaseService.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Combine
import Foundation
import OSLog
import SwiftUI

protocol DatabaseServiceProtocol {
    func fetchSavedCharactersList() -> AnyPublisher<[CharacterWithImage], Never>
    func fetchSavedCharacterEpisodes(_ character: CharacterWithImage) -> AnyPublisher<[Episode], Never>
    func saveCharacterRecords(_ character: CharacterWithImage)
}

final class DatabaseService: DatabaseServiceProtocol {
    private let client: DatabaseClientProtocol

    init(client: DatabaseClientProtocol) {
        self.client = client
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
