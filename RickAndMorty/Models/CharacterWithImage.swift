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
    let image: Image
}
