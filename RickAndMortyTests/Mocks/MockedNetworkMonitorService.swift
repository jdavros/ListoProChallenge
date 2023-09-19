//
//  MockedNetworkMonitorService.swift
//  RickAndMortyTests
//
//  Created by José Dávalos Rosas on 18/08/23.
//

import Foundation

@testable import RickAndMorty

final class MockedNetworkMonitorService: NetworkMonitorServiceProtocol {
    var isAppConnected: Bool
    var connectionType: RickAndMorty.ConnectionType

    init(with connectionType: ConnectionType) {
        self.connectionType = connectionType
        self.isAppConnected = false
    }

    func startMonitoring() {
        self.isAppConnected = connectionType != .unknown ? true : false
    }

    func stopMonitoring() {
        self.isAppConnected = false
    }

}
