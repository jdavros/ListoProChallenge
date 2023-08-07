//
//  MockedCharacterService.swift
//  RickAndMortyTests
//
//  Created by José Dávalos Rosas on 04/08/23.
//

import Combine
import Foundation
import SwiftUI

@testable import RickAndMorty

enum CharacterServiceState {
    case empty
    case error
    case populated
}

final class MockedCharacterService: CharacterServiceProtocol {

    let characterServiceState: CharacterServiceState

    init(with characterServiceState: CharacterServiceState) {
        self.characterServiceState = characterServiceState
    }

    func getCharactersList() -> AnyPublisher<[RickAndMorty.Character], Never> {
        switch characterServiceState {
        case .populated:
            return getMockedCharacters()
        default:
            return Just([]).eraseToAnyPublisher()
        }
    }

    func downloadCharactersImages(with character: RickAndMorty.Character) -> AnyPublisher<Image, Never> {
        return Just(Image("circle.person")).eraseToAnyPublisher()
    }
}

private extension MockedCharacterService {
    func getMockedCharacters() -> AnyPublisher<[Character], Never> {
        let charactersList: [Character] = [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
            ),
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
            ),
            Character(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                imageURL: "https://rickandmortyapi.com/api/character/avatar32.jpeg"
            ),
            Character(
                id: 4,
                name: "Abradolf Lincler",
                status: "Unknown",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/7.jpeg"
            ),
            Character(
                id: 5,
                name: "Agency Director",
                status: "Dead",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/9.jpeg"
            )
        ]

        return Just(charactersList)
            .eraseToAnyPublisher()
    }
}
