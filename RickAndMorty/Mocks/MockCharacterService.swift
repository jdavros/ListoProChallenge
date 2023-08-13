//
//  MockCharacterService.swift
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
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5"
                ]
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
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5"
                ]
            ),
            Character(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Female",
                origin: ExtraInfo(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                location: ExtraInfo(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar32.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5"
                ]
            ),
            Character(
                id: 4,
                name: "Abradolf Lincler",
                status: "Unknown",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                location: ExtraInfo(name: "Earth (Testicle Monster Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5"
                ]
            ),
            Character(
                id: 5,
                name: "Agency Director",
                status: "Dead",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                location: ExtraInfo(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
                episodes: [
                    "https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2",
                    "https://rickandmortyapi.com/api/episode/3",
                    "https://rickandmortyapi.com/api/episode/4",
                    "https://rickandmortyapi.com/api/episode/5"
                ]
            )
        ]

        return Just(charactersList)
            .eraseToAnyPublisher()
    }

    func getEpisodesList(with urls: [String]) -> AnyPublisher<[Episode], Error> {
        return Just([
            Episode(id: "S01E01", name: "Pilot"),
            Episode(id: "S01E02", name: "Lawnmower Dog"),
            Episode(id: "S01E03", name: "Anatomy Park"),
            Episode(id: "S01E04", name: "M. Night Shaym-Aliens!"),
            Episode(id: "S01E05", name: "Meeseeks and Destroy")
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    func downloadCharactersImages(with character: Character) -> AnyPublisher<Image, Never> {
        return Just(.characterPlaceholder)
            .eraseToAnyPublisher()
    }
}
