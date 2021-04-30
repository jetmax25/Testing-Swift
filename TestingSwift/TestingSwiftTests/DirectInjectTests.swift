//
//  DirectInjectTests.swift
//  TestingSwiftTests
//
//  Created by Michael Isasi on 4/29/21.
//

import XCTest
@testable import TestingSwift

class DirectInjectTests: XCTestCase {


    func testUserBuyUnpurchaseableAppIsFalse() {
        
        struct UnreleasedAppStub: AppProtocol {
            var price: Decimal = 0
            var minimumAge: Int = 0
            var isReleased: Bool = false
            
            func canBePurchased(by user: UserProtocol) -> Bool {
                return false
            }
        }
        
        var sut = DIUser(funds: 100, age: 21, apps: [])
        let app = UnreleasedAppStub()
        
        let wasBought = sut.buy(app)
        
        XCTAssertFalse(wasBought)
        
    }
}
