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
}

final class DetailViewModel: ObservableObject {

    @Published private(set) var isDetailListAvailable: Bool = true
    @Published private(set) var episodesDetails: [Episode] = []

    private var cancellables = Set<AnyCancellable>()
    private let episodeURLs: [String]
    private let service: CharacterServiceProtocol

    public init(
        episodeURLs: [String],
        service: CharacterServiceProtocol = CharacterService(client: URLSessionHttpClient())
    ) {
        self.episodeURLs = episodeURLs
        self.service = service
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func getEpisodesDetail() {
        service.getEpisodesList(with: episodeURLs)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.isDetailListAvailable = false
                case .finished:
                    self?.isDetailListAvailable = true
                }
            } receiveValue: { [weak self] in
                self?.episodesDetails = $0
            }
            .store(in: &cancellables)

    }
}
