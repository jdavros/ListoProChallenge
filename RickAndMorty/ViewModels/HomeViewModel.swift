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
            .flatMap(downloadCharactersImages(with:))
            .flatMap(\.publisher)
            .sink { [weak self] character in
                self?.charactersList.append(character)
                self?.databaseService.saveCharacterRecords(character)
                self?.loadingState = .loaded
                self?.startAnimation = false
            }
            .store(in: &cancellables)

    }

    private func downloadCharactersImages(with characters: [Character]) -> AnyPublisher<[CharacterWithImage], Never> {
        characters.publisher
            .flatMap(networkService.downloadCharactersImages(with:))
            .collect()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

    }
}
