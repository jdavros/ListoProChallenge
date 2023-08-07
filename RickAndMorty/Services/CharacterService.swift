//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import Combine
import Foundation
import OSLog
import SwiftUI

protocol CharacterServiceProtocol {
    func getCharactersList() -> AnyPublisher<[Character], Never>
    func downloadCharactersImages(with character: Character) -> AnyPublisher<Image, Never>
}

final class CharacterService: CharacterServiceProtocol {
    let cancellables = Set<AnyCancellable>()

    public func getCharactersList() -> AnyPublisher<[Character], Never> {
        let emptyCharacterArray = [Character]()
        let client = URLSessionHttpClient()

        guard let url = try? Endpoints.getEndpointURL(with: .character) else {
            Logger.networking.error("Converting path into an URL failed.")
            return Just(emptyCharacterArray)
                .eraseToAnyPublisher()
        }

        return client.get(url: url, model: ApiResponse.self)
            .map { $0.results }
            .replaceError(with: emptyCharacterArray)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func downloadCharactersImages(with character: Character) -> AnyPublisher<Image, Never> {
        let client = URLSessionHttpClient()

        guard let url = URL(string: character.imageURL) else {
            Logger.networking.error("Converting path into an URL failed.")
            return Just(.characterPlaceholder)
                .eraseToAnyPublisher()
        }

        return client.downloadImage(url: url)
            .replaceError(with: .characterPlaceholder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

private extension CharacterService {
    enum ServiceErrors: Error {
        case conversionError
    }
}
