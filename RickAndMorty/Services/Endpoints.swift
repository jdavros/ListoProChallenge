//
//  Endpoints.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import Foundation

enum PathsError: Error {
    case urlConversion
}

enum Paths: String {
    case character

    var name: String {
        switch self {
        case .character:
            return "/character"
        }
    }
}

struct Endpoints {
    private static let base: String = "https://rickandmortyapi.com/api"

    public static func getEndpointURL(with path: Paths) throws -> URL {
        guard let url = URL(string: "\(base)\(path.name)") else {
            throw PathsError.urlConversion
        }
        return url
    }
}
