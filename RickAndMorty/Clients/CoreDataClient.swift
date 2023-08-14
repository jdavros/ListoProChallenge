//
//  CoreDataClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Foundation
import CoreData
import OSLog

public final class CoreDataClient: DatabaseClientProtocol {
    let container: NSPersistentContainer
    @Published var savedCharacters: [CharacterEntity] = []
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { $savedCharacters }

    public init() {
        container = NSPersistentContainer(name: .containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                Logger.database.error("CoreData: Error loading database:\n\(error)")
            } else {
                Logger.database.info("CoreData: Successfully loaded database")
            }
        }
    }

    func fetchAllRecords() {
        let request = NSFetchRequest<CharacterEntity>(entityName: .characterEntityName)
        do {
            savedCharacters = try container.viewContext.fetch(request)
        } catch let error {
            Logger.database.error("CoreData: Error fetching Characters records.\n\(error)")
        }
    }

    func saveCharacterRecords(_ character: Character) {
        let newCharacter = CharacterEntity(context: container.viewContext)
        newCharacter.name = character.name
        saveData()
    }

    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            Logger.database.error("CoreData: Error Saving\n\(error)")
        }
    }

}

private extension String {
    static let containerName = "RickAndMortyContainer"
    static let characterEntityName = "CharacterEntity"
}
