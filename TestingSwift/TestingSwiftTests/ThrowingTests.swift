//
//  ThrowingTests.swift
//  TestingSwiftTests
//
//  Created by Michael Isasi on 4/28/21.
//

import XCTest
@testable import TestingSwift

class ThrowingTests: XCTestCase {

    func testPlayingBioBlitzThrows() {
        let game = Game(name: "BioBlitz")
        
        do {
            try game.play()
            XCTFail("BioBliz has not been purchased")
        } catch GameError.notPurchased {
            //success
        }
        catch {
            XCTFail()
        }
    }

    func testPlayingBlastazapThrows() {
        let game = Game(name: "Blastazap")
        XCTAssertThrowsError(try game.play()) { error in
            XCTAssertEqual(error as? GameError, .notInstalled)
        }
    }
    
    func testCrashyPlaneDoesentThrow() throws {
        let game = Game(name: "CrashyPlane")
        try game.play()
    }
}
