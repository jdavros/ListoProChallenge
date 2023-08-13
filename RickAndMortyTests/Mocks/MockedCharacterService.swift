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

    func getEpisodesList(with urls: [String]) -> AnyPublisher<[Episode], Error> {
        switch characterServiceState {
        case .empty:
            return Just([])
                .setFailureType(to: Error.self)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .error:
            return Fail(error: ServiceErrors.conversionError)
                .eraseToAnyPublisher()
        case .populated:
            return getMockedEpisodesList()
        }
    }
}

private extension MockedCharacterService {
    func getMockedCharacters() -> AnyPublisher<[Character], Never> {
        let charactersList: [Character] = [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episodes: .getMockedEpisodesURLList()
            ),
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episodes: .getMockedEpisodesURLList()
            ),
            Character(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Female",
                origin: ExtraInfo(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: ExtraInfo(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                imageURL: "https://rickandmortyapi.com/api/character/avatar32.jpeg",
                episodes: .getMockedEpisodesURLList()
            )
        ]

        return Just(charactersList)
            .eraseToAnyPublisher()
    }

    func getMockedEpisodesList() -> AnyPublisher<[Episode], Error> {
        return Just([
            Episode(id: "S01E01", name: "Pilot"),
            Episode(id: "S01E02", name: "Lawnmower Dog"),
            Episode(id: "S01E03", name: "Anatomy Park"),
            Episode(id: "S01E04", name: "M. Night Shaym-Aliens!"),
            Episode(id: "S01E05", name: "Meeseeks and Destroy")
        ])
        .setFailureType(to: Error.self)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

private extension MockedCharacterService {
    enum ServiceErrors: Error {
        case conversionError
    }
}
