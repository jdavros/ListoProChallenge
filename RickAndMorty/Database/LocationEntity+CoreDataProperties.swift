//
//  LocationEntity+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 16/08/23.
//
//

import Foundation
import CoreData

extension LocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationEntity> {
        return NSFetchRequest<LocationEntity>(entityName: "LocationEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var character: NSSet?

}

// MARK: Generated accessors for character
extension LocationEntity {

    @objc(addCharacterObject:)
    @NSManaged public func addToCharacter(_ value: CharacterEntity)

    @objc(removeCharacterObject:)
    @NSManaged public func removeFromCharacter(_ value: CharacterEntity)

    @objc(addCharacter:)
    @NSManaged public func addToCharacter(_ values: NSSet)

    @objc(removeCharacter:)
    @NSManaged public func removeFromCharacter(_ values: NSSet)

}

extension LocationEntity: Identifiable {

}
