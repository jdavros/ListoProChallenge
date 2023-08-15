//
//  MockDatabaseService.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Combine
import CoreData
import Foundation

public final class MockDatabaseService: DatabaseServiceProtocol {
    func fetchSavedCharactersList() -> AnyPublisher<[CharacterWithImage], Never> {
        return Just(MockedInformation.charactersWithImage)
            .eraseToAnyPublisher()
    }

    func saveCharacterRecords(_ character: CharacterWithImage) {
        print("MockDatabaseService: Character was saved successfully")
    }
}
