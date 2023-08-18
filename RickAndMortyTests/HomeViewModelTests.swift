//
//  HomeViewModelTests.swift
//  RickAndMortyTests
//
//  Created by José Dávalos Rosas on 04/08/23.
//

import XCTest
import Combine
import SwiftUI

@testable import RickAndMorty

final class HomeViewControllerTests: XCTestCase {

    func testHomeViewModel_retunsEmptyArray_whenNoActionIsTaken() {
        // Arrange
        let sut = makeSUT(state: .empty)
        // Assert

        XCTAssert(sut.charactersList.isEmpty)
    }

    func testHomeViewModel_returnsEmptyArray_whenServiceDoesntRetrieveCharacters() {
        // Arrange
        let sut = makeSUT(state: .empty)
        var cancellables = Set<AnyCancellable>()
        // Assert
        let exp = expectation(description: "Wait for characters to load")
        sut.$charactersList.sink { characters in
            XCTAssert(characters.isEmpty)
            XCTAssertEqual(sut.loadingState, .idle)
            exp.fulfill()
        }
        .store(in: &cancellables)
        // Act
        sut.getCharactersList()
        wait(for: [exp], timeout: 1.0)
    }

    func testHomeViewModel_returnsEmptyArray_whenServiceReturnsAnError() {
        // Arrange
        let sut = makeSUT(state: .error)
        var cancellables = Set<AnyCancellable>()
        // Assert
        let exp = expectation(description: "Wait for characters to load")
        sut.$charactersList.sink { characters in
            XCTAssert(characters.isEmpty)
            XCTAssertEqual(sut.loadingState, .idle)
            exp.fulfill()
        }
        .store(in: &cancellables)
        // Act
        sut.getCharactersList()
        wait(for: [exp], timeout: 1.0)
    }

    func testHomeViewModel_returnsArrayWithCharacters_whenServiceRetievesCharacters() {
            // Arrange
            let sut = makeSUT(state: .populated)
            var cancellables = Set<AnyCancellable>()
            let expectedCharactersList = mockCharacterList()
            let exp = expectation(description: "Wait for character to load")
        sut.$charactersList.sink(
            receiveValue: { _ in
                for (index, list) in expectedCharactersList.enumerated() {
                    XCTAssertEqual(list.id, expectedCharactersList[index].id)
                    XCTAssertEqual(list.name, expectedCharactersList[index].name)
                    XCTAssertEqual(list.status, expectedCharactersList[index].status)
                    XCTAssertEqual(list.species, expectedCharactersList[index].species)
                }
                exp.fulfill()
            }
        )
            .store(in: &cancellables)

            sut.getCharactersList()
            wait(for: [exp], timeout: 1.0)
        }

    // MARK: - Helper Functions
    private func makeSUT(state: ServiceState) -> HomeViewModel {
        let mockedCharacterService = MockedCharacterService(with: state)

        return HomeViewModel(
            networkService: mockedCharacterService,
            databaseService: DatabaseService(
                client: CoreDataClient(enableTestMode: true)
            )
        )
    }

    private func mockCharacterList() -> [Character] {
        return [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                episodes: .getMockedEpisodesURLList()
            ),
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Male",
                origin: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                location: ExtraInfo(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                imageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                episodes: .getMockedEpisodesURLList()
            ),
            Character(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                species: "Human",
                type: nil,
                gender: "Female",
                origin: ExtraInfo(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                location: ExtraInfo(
                    name: "Earth (Replacement Dimension)",
                    url: "https://rickandmortyapi.com/api/location/20"
                ),
                imageURL: "https://rickandmortyapi.com/api/character/avatar32.jpeg",
                episodes: .getMockedEpisodesURLList()
            )
        ]
    }

}
