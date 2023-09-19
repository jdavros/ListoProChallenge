//
//  EpisodeEntity+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 16/08/23.
//
//

import Foundation
import CoreData

extension EpisodeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EpisodeEntity> {
        return NSFetchRequest<EpisodeEntity>(entityName: "EpisodeEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var characters: NSSet?

}

// MARK: Generated accessors for characters
extension EpisodeEntity {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: CharacterEntity)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: CharacterEntity)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}

extension EpisodeEntity: Identifiable {

}
