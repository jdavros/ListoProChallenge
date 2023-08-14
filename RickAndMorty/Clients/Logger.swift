//
//  Logger.swift
//  RickAndMorty
//
//  Created by José Dávalos Rosas on 29/07/23.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let networking = Logger(subsystem: subsystem, category: "Networking")
    static let jsonDecoding = Logger(subsystem: subsystem, category: "JSON decoding")
    static let imageConversion = Logger(subsystem: subsystem, category: "Image conversion")
    static let database = Logger(subsystem: subsystem, category: "Database")
}
