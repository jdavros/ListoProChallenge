//
//  URLSessionHttpClient.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import Combine
import Foundation
import OSLog
import SwiftUI

protocol NetworkProtocol {
    func get<T: Decodable>(url: URL, model: T.Type) -> AnyPublisher<T, Error>
    func downloadImage(url: URL) -> AnyPublisher<Image, Error>
}

public class URLSessionHttpClient: NetworkProtocol {

    func get<T: Decodable>(url: URL, model: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: model, decoder: JSONDecoder())
            .mapError {
                Logger.jsonDecoding.error("\($0.localizedDescription)")
                return $0
            }
            .eraseToAnyPublisher()
    }

    func downloadImage(url: URL) -> AnyPublisher<Image, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .map {
                let uiImage = UIImage(data: $0) ?? UIImage()
                return Image(uiImage: uiImage)
            }
            .mapError {
                Logger.jsonDecoding.error("\($0.localizedDescription)")
                return $0
            }
            .eraseToAnyPublisher()
    }
}
