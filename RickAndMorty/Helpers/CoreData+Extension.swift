//
//  CoreData+Extension.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import CoreData

public extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
