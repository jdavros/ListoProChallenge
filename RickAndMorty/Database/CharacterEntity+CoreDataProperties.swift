//
//  CharacterEntity+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 16/08/23.
//
//

import Foundation
import CoreData

extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var gender: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var episodes: NSSet?
    @NSManaged public var location: LocationEntity?
    @NSManaged public var origin: OriginEntity?

}

// MARK: Generated accessors for episodes
extension CharacterEntity {

    @objc(addEpisodesObject:)
    @NSManaged public func addToEpisodes(_ value: EpisodeEntity)

    @objc(removeEpisodesObject:)
    @NSManaged public func removeFromEpisodes(_ value: EpisodeEntity)

    @objc(addEpisodes:)
    @NSManaged public func addToEpisodes(_ values: NSSet)

    @objc(removeEpisodes:)
    @NSManaged public func removeFromEpisodes(_ values: NSSet)

}

extension CharacterEntity: Identifiable {

}
