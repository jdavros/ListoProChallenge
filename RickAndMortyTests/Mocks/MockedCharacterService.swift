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

enum ServiceState {
    case empty
    case error
    case populated
}

final class MockedCharacterService: NetworkServiceProtocol {

    let serviceState: ServiceState

    init(with serviceState: ServiceState) {
        self.serviceState = serviceState
    }

    func getCharactersList() -> AnyPublisher<[RickAndMorty.Character], Never> {
        switch serviceState {
        case .populated:
            return getMockedCharacters()
        default:
            return Just([]).eraseToAnyPublisher()
        }
    }

    func downloadCharactersImages(with character: Character) -> AnyPublisher<CharacterWithImage, Never> {
        return Just(
            character.mapToCharacterWithImage(
                Image("circle.person")
            )
        )
        .eraseToAnyPublisher()
    }

    func getEpisodesList(with urls: [String]) -> AnyPublisher<[Episode], Error> {
        switch serviceState {
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
        return Just( [
            Episode(
                id: "S01E01",
                name: "Pilot",
                url: "https://rickandmortyapi.com/api/episode/1",
                characters: populateWithMockedCharacters()
            ),
            Episode(
                id: "S01E02",
                name: "Lawnmower Dog",
                url: "https://rickandmortyapi.com/api/episode/2",
                characters: populateWithMockedCharacters()),
            Episode(
                id: "S01E03",
                name: "Anatomy Park",
                url: "https://rickandmortyapi.com/api/episode/3",
                characters: populateWithMockedCharacters()),
            Episode(
                id: "S01E04",
                name: "M. Night Shaym-Aliens!",
                url: "https://rickandmortyapi.com/api/episode/4",
                characters: populateWithMockedCharacters()),
            Episode(
                id: "S01E05",
                name: "Meeseeks and Destroy",
                url: "https://rickandmortyapi.com/api/episode/5",
                characters: populateWithMockedCharacters())
        ])
        .setFailureType(to: Error.self)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    private func populateWithMockedCharacters() -> [String] {
        return [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/3",
            "https://rickandmortyapi.com/api/character/4",
            "https://rickandmortyapi.com/api/character/5"
        ]
    }
}

private extension MockedCharacterService {
    enum ServiceErrors: Error {
        case conversionError
    }
}
