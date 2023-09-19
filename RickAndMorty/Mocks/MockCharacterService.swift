//
//  MockCharacterService.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 30/07/23.
//

import Combine
import Foundation
import SwiftUI

public final class MockCharacterService: NetworkServiceProtocol {

    func getCharactersList() -> AnyPublisher<[Character], Never> {
        return Just(MockedInformation.characters)
            .eraseToAnyPublisher()
    }

    func getEpisodesList(with urls: [String]) -> AnyPublisher<[Episode], Error> {
        return Just(Array.getMockedEpisodesList())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    func downloadCharactersImages(with character: Character) -> AnyPublisher<CharacterWithImage, Never> {
        Just(character.mapToCharacterWithImage(.characterPlaceholder))
            .eraseToAnyPublisher()
    }
}
