//
//  MockHomeViewModel.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 30/07/23.
//

import Combine
import Foundation
import SwiftUI

public final class MockCharacterService: CharacterServiceProtocol {
    func getCharactersList() -> AnyPublisher<[Character], Never> {
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

    func downloadCharactersImages(with character: Character) -> AnyPublisher<Image, Never> {
        return Just(.characterPlaceholder)
            .eraseToAnyPublisher()
    }
}
