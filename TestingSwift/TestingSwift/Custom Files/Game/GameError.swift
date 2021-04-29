//
//  GameError.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/28/21.
//

import Foundation

enum GameError: Error {
    case notPurchased
    case notInstalled
    case parentalControlsDisallowed
}

extension GameError: LocalizedError {
    var errorDescription: String? {
        return "\(self)"
    }
}
