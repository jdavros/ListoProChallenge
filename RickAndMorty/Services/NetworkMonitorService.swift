//
//  NetworkMonitorService.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 18/08/23.
//

import Foundation
import Network

protocol NetworkMonitorServiceProtocol {
    var isAppConnected: Bool { get }
    var connectionType: ConnectionType { get }
    func startMonitoring()
    func stopMonitoring()
}

public enum ConnectionType {
    case cellular
    case wifi
    case wired
    case unknown
}

public final class NetworkMonitorService {
    public private(set) var isAppConnected: Bool = false
    public private(set) var connectionType: ConnectionType

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public init() {
        monitor = NWPathMonitor()
        self.connectionType = .unknown
    }

    private func getConnectionType(with path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            self.connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self.connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            self.connectionType = .wired
        } else {
            self.connectionType = .unknown
        }
    }
}

extension NetworkMonitorService: NetworkMonitorServiceProtocol {
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isAppConnected = path.status != .unsatisfied
            self?.getConnectionType(with: path)
        }
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}
