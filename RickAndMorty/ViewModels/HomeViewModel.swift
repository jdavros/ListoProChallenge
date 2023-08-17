//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import Combine
import SwiftUI

enum LoadingState {
    case idle
    case failed
    case loaded
}

protocol HomeViewModelProtocol {
    func getCharactersList()
    func downloadCharactersImages(with characters: [Character])
}

final class HomeViewModel: ObservableObject {

    @Published private(set) var charactersList: [CharacterWithImage] = []
    @Published private(set) var loadingState: LoadingState = .idle
    @Published private(set) var startAnimation: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol

    public init(
        networkService: NetworkServiceProtocol = NetworkService(client: URLSessionHttpClient()),
        databaseService: DatabaseServiceProtocol = DatabaseService(client: DatabaseClient(with: .coredata))
    ) {
        self.startAnimation = true
        self.networkService = networkService
        self.databaseService = databaseService
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    public func getCharactersList() {
        networkService.getCharactersList()
            .sink { [weak self] characters in
                self?.downloadCharactersImages(with: characters)
            }
            .store(in: &cancellables)
    }

    public func downloadCharactersImages(with characters: [Character]) {
        for character in characters {
            networkService.downloadCharactersImages(with: character)
                .sink { [weak self] image in
                    let retrievedCharacter = character.mapToCharacterWithImage(image)
                    self?.databaseService.saveCharacterRecords(retrievedCharacter)
                    self?.charactersList.append(retrievedCharacter)
                    self?.loadingState = .loaded
                    self?.startAnimation = false
                }
                .store(in: &cancellables)

        }
    }
}

private extension Character {
    func mapToCharacterWithImage(_ image: Image) -> CharacterWithImage {
        return CharacterWithImage(
            id: self.id,
            name: self.name,
            status: self.status,
            species: self.species,
            type: self.type ?? "",
            gender: self.gender,
            origin: self.origin,
            location: self.location,
            image: image,
            episodesURLs: self.episodes,
            episodes: []
        )
    }
}
