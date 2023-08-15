//
//  DetailViewModel.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 10/08/23.
//

import Combine
import SwiftUI

protocol DetailViewModelProtocol {
    func getEpisodesDetail()
    func saveEpisodes(for character: CharacterWithImage?)
}

final class DetailViewModel: ObservableObject {

    @Published private(set) var isDetailListAvailable: Bool = true
    @Published private(set) var episodesDetails: [Episode] = []

    private var cancellables = Set<AnyCancellable>()
    private var character: CharacterWithImage
    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol

    public init(
        character: CharacterWithImage,
        networkService: NetworkServiceProtocol? =  nil,
        databaseService: DatabaseServiceProtocol? = nil
    ) {
        self.character = character
        self.networkService = networkService ?? NetworkService(client: URLSessionHttpClient())
        self.databaseService = databaseService ?? DatabaseService(client: DatabaseClient(with: .coredata))
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func getEpisodesDetail() {
        networkService.getEpisodesList(with: character.episodesURLs)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.isDetailListAvailable = false
                case .finished:
                    self?.isDetailListAvailable = true
                }
            } receiveValue: { [weak self] in
                self?.character.episodes = $0
                self?.episodesDetails = $0
                self?.saveEpisodes(for: self?.character)
            }
            .store(in: &cancellables)
    }

    func saveEpisodes(for character: CharacterWithImage?) {
        guard let character = character else { return }
        databaseService.saveCharacterRecords(character)
    }
}
