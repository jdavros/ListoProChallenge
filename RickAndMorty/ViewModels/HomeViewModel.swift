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

    private var cancellables = Set<AnyCancellable>()
    private let service: CharacterServiceProtocol

    public init(service: CharacterServiceProtocol = CharacterService()) {
        self.service = service
    }

    public func getCharactersList() {
        service.getCharactersList()
            .sink { [weak self] characters in
                self?.downloadCharactersImages(with: characters)
            }
            .store(in: &cancellables)
    }

    public func downloadCharactersImages(with characters: [Character]) {
        for character in characters {
            service.downloadCharactersImages(with: character)
                .sink { [weak self] image in
                    self?.loadingState = .loaded
                    self?.charactersList.append(character.mapToCharacterWithImage(image))
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
            image: image
        )
    }
}
