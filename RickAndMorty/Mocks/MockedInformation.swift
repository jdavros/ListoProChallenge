//
//  MockedInformation.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Foundation

public struct MockedInformation {
    static let characters: [Character] = [
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
        ),
        Character(
            id: 4,
            name: "Abradolf Lincler",
            status: "Unknown",
            species: "Human",
            type: nil,
            gender: "Male",
            origin: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            location: ExtraInfo(
                name: "Earth (Testicle Monster Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            imageURL: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
            episodes: .getMockedEpisodesURLList()
        ),
        Character(
            id: 5,
            name: "Agency Director",
            status: "Dead",
            species: "Human",
            type: nil,
            gender: "Male",
            origin: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            location: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            imageURL: "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
            episodes: .getMockedEpisodesURLList()
        )
    ]

    static let charactersWithImage: [CharacterWithImage] = [
        CharacterWithImage(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: ExtraInfo(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
            location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
            image: .characterPlaceholder,
            episodesURLs: .getMockedEpisodesURLList(),
            episodes: .getMockedEpisodesList()
        ),
        CharacterWithImage(
            id: 2,
            name: "Morty Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
            location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
            image: .characterPlaceholder,
            episodesURLs: .getMockedEpisodesURLList(),
            episodes: .getMockedEpisodesList()
        ),
        CharacterWithImage(
            id: 3,
            name: "Summer Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Female",
            origin: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            location: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            image: .characterPlaceholder,
            episodesURLs: .getMockedEpisodesURLList(),
            episodes: .getMockedEpisodesList()
        ),
        CharacterWithImage(
            id: 4,
            name: "Abradolf Lincler",
            status: "Unknown",
            species: "Human",
            type: "",
            gender: "Male",
            origin: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            location: ExtraInfo(
                name: "Earth (Testicle Monster Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            image: .characterPlaceholder,
            episodesURLs: .getMockedEpisodesURLList(),
            episodes: .getMockedEpisodesList()
        ),
        CharacterWithImage(
            id: 5,
            name: "Agency Director",
            status: "Dead",
            species: "Human",
            type: "",
            gender: "Male",
            origin: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            location: ExtraInfo(
                name: "Earth (Replacement Dimension)",
                url: "https://rickandmortyapi.com/api/location/20"
            ),
            image: .characterPlaceholder,
            episodesURLs: .getMockedEpisodesURLList(),
            episodes: .getMockedEpisodesList()
        )
    ]
}

extension Collection where Element == String {
    static func getMockedEpisodesURLList() -> [String] {
        return [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3",
            "https://rickandmortyapi.com/api/episode/4",
            "https://rickandmortyapi.com/api/episode/5"
        ]
    }

    static func getMockedCharactersURLList() -> [String] {
        return [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/3",
            "https://rickandmortyapi.com/api/character/4",
            "https://rickandmortyapi.com/api/character/5"
        ]
    }
}

extension Collection where Element == Episode {
    static func getMockedEpisodesList() -> [Episode] {
        let characters: [String] = .getMockedCharactersURLList()
        return [
            Episode(
                id: "S01E01",
                name: "Pilot",
                url: "https://rickandmortyapi.com/api/episode/1",
                characters: characters
            ),
            Episode(
                id: "S01E02",
                name: "Lawnmower Dog",
                url: "https://rickandmortyapi.com/api/episode/2",
                characters: characters),
            Episode(
                id: "S01E03",
                name: "Anatomy Park",
                url: "https://rickandmortyapi.com/api/episode/3",
                characters: characters),
            Episode(
                id: "S01E04",
                name: "M. Night Shaym-Aliens!",
                url: "https://rickandmortyapi.com/api/episode/4",
                characters: characters),
            Episode(
                id: "S01E05",
                name: "Meeseeks and Destroy",
                url: "https://rickandmortyapi.com/api/episode/5",
                characters: characters)
        ]
    }
}
