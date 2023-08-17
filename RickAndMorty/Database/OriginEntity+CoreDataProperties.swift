//
//  OriginEntity+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 16/08/23.
//
//

import Foundation
import CoreData

extension OriginEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OriginEntity> {
        return NSFetchRequest<OriginEntity>(entityName: "OriginEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var character: NSSet?

}

// MARK: Generated accessors for character
extension OriginEntity {

    @objc(addCharacterObject:)
    @NSManaged public func addToCharacter(_ value: CharacterEntity)

    @objc(removeCharacterObject:)
    @NSManaged public func removeFromCharacter(_ value: CharacterEntity)

    @objc(addCharacter:)
    @NSManaged public func addToCharacter(_ values: NSSet)

    @objc(removeCharacter:)
    @NSManaged public func removeFromCharacter(_ values: NSSet)

}

extension OriginEntity: Identifiable {

}
