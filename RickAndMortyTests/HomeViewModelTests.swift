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
        let expectedCharactersList: [Character] = [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
            ),
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
            ),
            Character(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                imageURL: "https://rickandmortyapi.com/api/character/avatar32.jpeg"
            ),
            Character(
                id: 4,
                name: "Abradolf Lincler",
                status: "Unknown",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/7.jpeg"
            ),
            Character(
                id: 5,
                name: "Agency Director",
                status: "Dead",
                imageURL: "https://rickandmortyapi.com/api/character/avatar/9.jpeg"
            )
        ]
        // Assert
        let exp = expectation(description: "Wait for characters to load")
        sut.$charactersList.sink { characters in
            for (index, character) in characters.enumerated() {
                XCTAssertEqual(character.id, expectedCharactersList[index].id)
                XCTAssertEqual(character.name, expectedCharactersList[index].name)
                XCTAssertEqual(character.status, expectedCharactersList[index].status)
            }
            exp.fulfill()
        }
        .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
    }

    private func makeSUT(state: CharacterServiceState) -> HomeViewModel {
        let mockedCharacterService = MockedCharacterService(with: state)
        return HomeViewModel(service: mockedCharacterService)
    }

}
