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

    let episodeURLs: [String]
    let service: CharacterService
    @Published var episodesDetails: [Episode]

    init(
        episodeURLs: [String],
        episodesDetails: [Episode] = [Episode](),
        service: CharacterServiceProtocol = CharacterService()
    ) {
        self.episodeURLs = episodeURLs
        self.episodesDetails = episodesDetails
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func getEpisodesDetail() {
        <#code#>
    }
}
