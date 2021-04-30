//
//  XCUITestSandboxUITests.swift
//  XCUITestSandboxUITests
//
//  Created by Michael Isasi on 4/30/21.
//  Copyright © 2021 Hacking with Swift. All rights reserved.
//

import XCTest

class XCUITestSandboxUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.textFields.element.tap()
        
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        
        app.keyboards.buttons["Return"].tap()
        app.sliders["Completion"].swipeRight()
        
        app.segmentedControls.buttons["Omega"].tap()
        app.buttons["Blue"].tap()
        app.alerts["Blue"].buttons["OK"].tap()
                
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLabelCopiesTextField() {
        let app = XCUIApplication()
        app.textFields.element.tap()

        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertEqual(app.staticTexts["TextCopy"].label, "test")
    }
    
    func testSliderControlsProgress() {
        let app = XCUIApplication()
        app.sliders["Completion"].adjust(toNormalizedSliderPosition: 1)
        
        guard let completion = app.progressIndicators.element.value as? String else {
            XCTFail("Unable to find the progress indicator")
            return
        }
        
        XCTAssertEqual(completion, "0%")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testButtonsShowAlerts() {
        let app = XCUIApplication()
        app.buttons["Blue"].tap()
        XCTAssertTrue(app.alerts["Blue"].exists)
        app.alerts["Blue"].buttons["OK"].tap()
    }
    
    func testSemgentedControl() {
        let app = XCUIApplication()
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Test"
        attachment.lifetime = .deleteOnSuccess
        add(attachment)
        
        app.segmentedControls.firstMatch.buttons.element(boundBy: 1).tap()
        


        XCTAssertEqual(app.navigationBars.element.staticTexts.element.label, "Omega")
    }
}
