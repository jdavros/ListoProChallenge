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

public final class CoreDataClient: DatabaseClientProtocol {
    @Published var savedCharacters: [CharacterEntity] = []
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { $savedCharacters }

    let container: NSPersistentContainer

    public init() {
        container = NSPersistentContainer(name: .containerName)
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
            episodes.append(episodeEntity)
        }
        saveData()
    }

    private func saveData() {
        do {
            try container.viewContext.save()
            Logger.database.info("CoreData: The data was saved successfully")
        } catch let error {
            Logger.database.error("CoreData: Error Saving\n\(error)")
        }
    }

}

private extension String {
    static let containerName = "RickAndMortyContainer"
    static let characterEntityName = "CharacterEntity"
}
