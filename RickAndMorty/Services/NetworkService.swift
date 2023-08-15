//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import Combine
import Foundation
import OSLog
import SwiftUI

protocol NetworkServiceProtocol {
    func getCharactersList() -> AnyPublisher<[Character], Never>
    func getEpisodesList(with urls: [String]) -> AnyPublisher<[Episode], Error>
    func downloadCharactersImages(with character: Character) -> AnyPublisher<Image, Never>
}

final class NetworkService: NetworkServiceProtocol {
    private var cancellables = Set<AnyCancellable>()
    private let client: NetworkProtocol

    init(client: NetworkProtocol) {
        self.client = client
    }

    public func getCharactersList() -> AnyPublisher<[Character], Never> {
        guard let url = try? Endpoints.getEndpointURL(with: .character) else {
            Logger.networking.error("Converting path into an URL failed.")
            return Just([Character]())
                .eraseToAnyPublisher()
        }

        return client.get(url: url, model: ApiResponse.self)
            .map { $0.results }
            .replaceError(with: [Character]())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func getEpisodesList(with urls: [String]) -> AnyPublisher<[Episode], Error> {
        urls.publisher
            .compactMap { URL(string: $0) }
            .flatMap {
                self.client.get(url: $0, model: Episode.self)
            }
            .collect()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func downloadCharactersImages(with character: Character) -> AnyPublisher<Image, Never> {
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
