//
//  AsynchronousTests.swift
//  AsynchronousTests
//
//  Created by Michael Isasi on 4/28/21.
//

import XCTest
@testable import TestingSwift

class AsynchronousTests: XCTestCase {

    func testPrimesUpTo100ShouldBe25() {
        let maximumCount = 100
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")

        PrimeCalculator.calculateProgress(upTo: maximumCount) {values in
            XCTAssertEqual(values.count, 25)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func testPrimesUpTo100ShouldBe25WithProgress() {
        let maxCount = 100
        
        let progress: Progress = PrimeCalculator.calculateProgress(upTo: maxCount) {
            XCTAssertEqual($0.count, 25)
        }
        
        
        let predicate = NSPredicate(format: "%@.completedUnitCount == %@", argumentArray: [progress, maxCount])
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: progress)
        wait(for: [expectation], timeout: 2)
    }
    
    func testPrimeCalculatorStreamingCountShouldBe25() {
        let maxCount = 100
        
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        var primeCounter = 0
        
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maxCount)")
        expectation.expectedFulfillmentCount = 25
        
        PrimeCalculator.calculateStreaming(upTo: maxCount) { prime in
            XCTAssertEqual(primes[primeCounter], prime)
            expectation.fulfill()
            primeCounter += 1
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testLinkedInUserUpgradedPostsNotification() {
        let user = LinkedInUser()
        let center = NotificationCenter()
        
        let expectation = XCTNSNotificationExpectation(name: LinkedInUser.upgradedNotification, object: nil, notificationCenter: center)
        expectation.handler = { notification -> Bool in
            guard let level = notification.userInfo?[LinkedInUser.Level.key] as? LinkedInUser.Level else { return false }
            return level == .gold
        }
        
        user.upgrade(using: center)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testPrimeCalculatoreSyncPrimePerformance() {
        measure {
            _ = PrimeCalculator.syncCalculate(upTo: 1_000_000)
        }
    }
}
