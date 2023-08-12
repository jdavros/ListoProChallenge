//
//  CharacterWithImage.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 01/08/23.
//

import Foundation
import SwiftUI

struct CharacterWithImage: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: ExtraInfo
    let location: ExtraInfo
    let image: Image
    let episodes: [String]
}
