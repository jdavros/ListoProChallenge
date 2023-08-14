//
//  ExtraInfo.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Foundation
import CoreData
import OSLog

struct ExtraInfo: Codable {
    let name: String
    let url: String?

    init(name: String, url: String?) {
        self.name = name
        self.url = url
    }

    init?(entity: OriginEntity?) throws {
        guard let name = entity?.name else {
            Logger.database.error("CoreData: Entity to Model conversion failed.\n\(ModelCreation.conversionError)")
            throw ModelCreation.conversionError
        }
        self.name = name
        self.url = entity?.url
    }

    init?(entity: LocationEntity?) throws {
        guard let name = entity?.name else {
            Logger.database.error("CoreData: Entity to Model conversion failed.\n\(ModelCreation.conversionError)")
            throw ModelCreation.conversionError
        }
        self.name = name
        self.url = entity?.url
    }
}
