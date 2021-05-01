//
//  TDDUserTests.swift
//  TDDTests
//
//  Created by Michael Isasi on 4/30/21.
//

import XCTest
@testable import TDD

class TDDUserTests: XCTestCase {

    func DISABLED_testReadingBookAddsToLibrary() {
        let bookToBuy = "Great Expectations"
        var user = User()
        
        user.buy(bookToBuy)
        
        XCTAssertTrue(user.owns(bookToBuy))
    }

}
