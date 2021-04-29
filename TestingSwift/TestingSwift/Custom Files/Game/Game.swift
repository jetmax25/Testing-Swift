//
//  Game.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/28/21.
//

struct Game {
    let name: String
    
    func play() throws {
        switch name {
        case "BioBlitz": throw GameError.notPurchased
        case "Blastazap": throw GameError.notInstalled
        case "Dead Storm Rising": throw GameError.parentalControlsDisallowed
        default: print( "\(name) is OK to play")
        }
    }
}
