//
//  MockingTests.swift
//  TestingSwiftTests
//
//  Created by Michael Isasi on 4/29/21.
//

import XCTest
@testable import TestingSwift

class MockingTests: XCTestCase {

    func testViewingHouseAddsOneToViewings() {
        let house = House()
        let startViewings = house.numberOfViewings
        
        house.conductViewing()
        
        XCTAssertEqual(house.numberOfViewings, startViewings + 1)
    }
    
    func testBuyerViewingHouseAddsOneToViewings() {
        class HouseMock: HouseProtocol {
            var numberOfViewings = 0
            
            func conductViewing() {
                numberOfViewings += 1
            }
        }
        
        let buyer = Buyer()
        let house = HouseMock()
        
        buyer.view(house)
        
        XCTAssertEqual(house.numberOfViewings, 1)
    }
    
    class DeviceMock: UIDevice {
        var testBatteryState: BatteryState
        
        init(testBatteryState: BatteryState) {
            self.testBatteryState = testBatteryState
            super.init()
        }
        
        override var batteryState: UIDevice.BatteryState {
            print(testBatteryState)
            return testBatteryState
        }
    }
    
    func testPowerMonitorStatusBatteryStateUnpluggedReturnsPowerIsDown() {
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: .unplugged))
        
        let message = sut.getStatus()
        
        XCTAssertEqual(message, "Power is down")
    }
    
    func testPowerMonitorStatusBatteryStateUnknownIsError() {
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: .unknown))
        
        let message = sut.getStatus()
        
        XCTAssertEqual(message, "Error")
    }
    
    func testPowerMonitorStatusBatteryStateWorkingIsPowerUp() {
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: .full))
        
        let message = sut.getStatus()
        
        XCTAssertEqual(message, "Power is up")
    }
}

extension MockingTests {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    class DataTaskMock: URLSessionDataTask {
        var completionHandler: CompletionHandler
        var resumeWasCalled = false
        
        init(completionHandler: @escaping CompletionHandler) {
            self.completionHandler = completionHandler
        }
        
        override func resume() {
            resumeWasCalled = true
            completionHandler(nil, nil, nil)
        }
    }
    
    class URLSessionMock: URLSessionProtocol {
        var dataTask: DataTaskMock?
        var lastURL: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
            lastURL = url
            let newDataTask = DataTaskMock(completionHandler: completionHandler)
            self.dataTask = newDataTask
            return newDataTask
        }
    }
    
    func testNewsFetchLoadsCorrectURL() {
        
        let url = URL(string: "https://wwww.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloading news stories")
        
        news.fetch(using: session) {
            XCTAssertEqual(URL(string: "https://wwww.apple.com/newsroom/rss-feed.rss"), session.lastURL)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsFetchCallsResume() {
        let url = URL(string: "https://wwww.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume()")
        
        news.fetch(using: session) {
            XCTAssertNotNil(session.dataTask)
            XCTAssertTrue(session.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsStoriesAreFetched() {
        class NeverFireDataTaskMock: URLSessionDataTask {
            override func resume() {}
        }
        
        class DataSessionMock: URLSessionProtocol {
            var testData: Data?
            
            func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
                defer {
                    completionHandler(testData, nil, nil)
                }
                return NeverFireDataTaskMock()
            }
        }
        
        let url = URL(string: "https://wwww.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = DataSessionMock()
        session.testData = Data("News Data".utf8)
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume")
        
        news.fetch(using: session) {
            XCTAssertEqual(news.stories, "News Data")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsStoriesAreFetchedUsingProtocolMock() {
        let url = URL(string: "https://wwww.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume")
        URLProtocolMock.testURLs = [url: Data("Test Data".utf8)]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        news.fetch(using: session) {
            XCTAssertEqual(news.stories, "Test Data")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL: Data]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url, let data = Self.testURLs[url] {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
