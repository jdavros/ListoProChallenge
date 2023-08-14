//
//  RealmClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 14/08/23.
//

import Foundation
import CoreData

final class RealmClient: DatabaseClientProtocol {
    @Published var savedCharacters: [CharacterEntity] = []
    var savedCharactersPublisher: Published<[CharacterEntity]>.Publisher { $savedCharacters }

    init() {

    }

    func fetchAllRecords() {
        #warning("Needs implementation")
    }

    func saveCharacterRecords(_ character: Character) {
        #warning("Needs implementation")
    }
}
