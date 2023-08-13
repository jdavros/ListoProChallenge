//
//  DetailViewModelTests.swift
//  RickAndMortyTests
//
//  Created by José Dávalos Rosas on 13/08/23.
//

import XCTest
import Combine
import SwiftUI

@testable import RickAndMorty

final class DetailViewModelTests: XCTestCase {

    func testDetailViewModel_returnsEmptyList_whenNoActionIsTaken() {
        // Arrange
        let sut = makeSUT(state: .empty)
        // Assert
        XCTAssertTrue(sut.episodesDetails.isEmpty)
    }

    func testDetailViewModel_returnsEmptyArray_whenServiceDoesntRetrieveEpisodes() {
        // Arrange
        let sut = makeSUT(episodesURLs: .getMockedEpisodesURLList(), state: .empty)
        var cancellables = Set<AnyCancellable>()
        // Assert
        let exp = expectation(description: "Wait for episodes to load")
        sut.$episodesDetails.sink { episodes in
            XCTAssertTrue(episodes.isEmpty)
            exp.fulfill()
        }
        .store(in: &cancellables)
        // Act
        sut.getEpisodesDetail()
        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(sut.isDetailListAvailable)
    }

    func testDetailViewModel_returnsEpisodesArray_whenServiceRetrievesEpisodes() {
        // Arrange
        let sut = makeSUT(episodesURLs: .getMockedEpisodesURLList(), state: .populated)
        var cancellables = Set<AnyCancellable>()
        let expectedEpisodesList: [Episode] = .getMockedEpisodesList()
        // Assert
        let exp = [
            expectation(description: "Wait for the first episode to load"),
            expectation(description: "Wait for the second episode to load"),
            expectation(description: "Wait for the third episode to load"),
            expectation(description: "Wait for the fourth episode to load"),
            expectation(description: "Wait for the fifth episode to load")
        ]
        sut.$episodesDetails.sink { episodes in
            for (index, episode) in episodes.enumerated() {
                XCTAssertEqual(episode.id, expectedEpisodesList[index].id)
                XCTAssertEqual(episode.name, expectedEpisodesList[index].name)
                exp[index].fulfill()
            }
        }
        .store(in: &cancellables)
        // Act
        sut.getEpisodesDetail()
        wait(for: exp, timeout: 1.0)
        XCTAssertTrue(sut.isDetailListAvailable)
    }

    func testDetailViewModel_returnsEmptyArray_whenServiceReturnsWithError() {
        // Arrange
        let sut = makeSUT(episodesURLs: .getMockedEpisodesURLList(), state: .error)
        var cancellables = Set<AnyCancellable>()
        // Assert
        let exp = expectation(description: "Wait for episodes to load")
        sut.$episodesDetails.sink { episodes in
            XCTAssertTrue(episodes.isEmpty)
            exp.fulfill()
        }
        .store(in: &cancellables)
        // Act
        sut.getEpisodesDetail()
        wait(for: [exp], timeout: 1.0)
        XCTAssertFalse(sut.isDetailListAvailable)
    }

    private func makeSUT(
        episodesURLs: [String] = [],
        state: CharacterServiceState
    ) -> DetailViewModel {
        let mockedCharacterService = MockedCharacterService(with: state)
        return DetailViewModel(episodeURLs: episodesURLs, service: mockedCharacterService)
    }
}
