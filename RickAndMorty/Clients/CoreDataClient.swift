//
//  CoreDataClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Foundation
import Combine
import CoreData
import OSLog

enum CoreDataError: Error {
    case conversion(String)
}

public final class CoreDataClient: DatabaseClientProtocol {
    @Published var savedCharacters: [CharacterEntity] = []
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { $savedCharacters }

    let container: NSPersistentContainer

    public init(enableTestMode: Bool = false) {
        container = NSPersistentContainer(name: .containerName)
        if enableTestMode {
            let description = NSPersistentStoreDescription(
                url: URL(filePath: "/dev/null")
            )
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                Logger.database.error("CoreData: Error loading database:\n\(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

    func fetchSavedCharactersList() -> AnyPublisher<[CharacterWithImage], Never> {
        let request = NSFetchRequest<CharacterEntity>(entityName: .characterEntityName)
        var characters = [CharacterWithImage]()
        do {
            let savedCharacters = try container.viewContext.fetch(request)
            for savedCharacter in savedCharacters {
                let characterWithImage = try CharacterWithImage(entity: savedCharacter)
                characters.append(characterWithImage)
            }
        } catch let error {
            Logger.database.error("CoreData: Error fetching Characters records.\n\(error)")
        }
        return Just(characters)
            .eraseToAnyPublisher()
    }

    func fetchSavedCharacterEpisodes(_ character: CharacterWithImage) -> AnyPublisher<[Episode], Never> {
        var episodes = [Episode]()

        let request = NSFetchRequest<EpisodeEntity>(entityName: .episodeEntityName)
        request.predicate = NSPredicate(format: "url in %@", character.episodesURLs)

        do {
            let savedEpisodes = try container.viewContext.fetch(request)
            for savedEpisode in savedEpisodes {
                let episode = try Episode(entity: savedEpisode)
                episodes.append(episode)
            }
        } catch let error {
            Logger.database.error("CoreData: Error fetching episodes. \(error)")
        }

        return Just(episodes)
            .eraseToAnyPublisher()
    }

    func saveCharacterRecords(_ character: CharacterWithImage) {
        let managedObjectContext = container.viewContext
        let newCharacter = CharacterEntity(context: managedObjectContext)
        let origin = OriginEntity(context: managedObjectContext)
        let location = LocationEntity(context: managedObjectContext)
        var episodes = [EpisodeEntity]()

        newCharacter.id = Int32(character.id)
        newCharacter.name = character.name
        newCharacter.status = character.status
        newCharacter.species = character.species
        newCharacter.type = character.type
        newCharacter.gender = character.gender

        origin.name = character.origin.name
        origin.url = character.origin.url
        newCharacter.origin = origin

        location.name = character.location.name
        location.url = character.location.url
        newCharacter.location = location

        for (index, episode) in character.episodes.enumerated() {
            let episodeEntity = EpisodeEntity(context: managedObjectContext)
            episodeEntity.id = episode.id
            episodeEntity.name = episode.name
            episodeEntity.url = character.episodesURLs[index]
            episodeEntity.characters = NSSet(
                array: fetchSavedCharacterEntities(episode.characters)
            )
            episodes.append(episodeEntity)
        }
        saveData()
    }

    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            Logger.database.error("CoreData: Error Saving\n\(error)")
        }
    }

    private func fetchSavedCharacterEntities(_ urls: [String]) -> [CharacterEntity] {
        var characters = [CharacterEntity]()
        do {
            let ids = try getIds(from: urls)
            for id in ids {
                let request = NSFetchRequest<CharacterEntity>(entityName: .characterEntityName)
                request.predicate = NSPredicate(format: "id == %d", id)
                guard let savedCharacter = try container.viewContext.fetch(request).first else {
                    throw CoreDataError.conversion("Character: \(id)")
                }
                characters.append(savedCharacter)
            }
        } catch let error {
            Logger.database.error("CoreData: Error fetching character. \(error)")
        }
        return characters
    }

    private func getIds(from urls: [String]) throws -> [Int] {
        var ids = [Int]()
        for url in urls {
            let range = NSRange(location: 0, length: url.utf16.count)
            let regex = try NSRegularExpression(pattern: "\\d+")
            guard let match = regex.firstMatch(in: url, range: range),
                  let range = Range(match.range, in: url),
                  let matchingId = Int(url[range]) else {
                Logger.database.error("There was an error trying to get the character ID from the given URL.")
                throw CoreDataError.conversion(url)
            }
            ids.append(matchingId)
        }
        return ids
    }
}

private extension String {
    static let containerName = "RickAndMortyContainer"
    static let characterEntityName = "CharacterEntity"
    static let episodeEntityName = "EpisodeEntity"
}
