# Chapter 4 - User Interface Testing

## Best Practices
* Use on screen keyboard
* Create testing bundle when it does not already exist
    * >File -> New -> Target -> iOS UI Tetsing Bundle
* Place a command line parameter that the app can read and adapt to
    * *EG:* Replace `XCUIApplication().launch()` with 
    > ```
    > let app = XCUIApplication()
    > app.launchArguments = ["enable-testing]
    > app.launch()
    * Doing so allows selective execution in the main app
    > ```
    > #if DEBUG
    > if CommandLine.arguments.contains("en-able-testing") {
    >   configureAppForTesting()
    > }
    > #endif
* Set accecibility identity property for each element in order to access it easily
* Use `XCTContext.runActivity(named: String)` to group actions together

## Recording Tests
1. Put carot into test mathod
2. Click the red record button in the bottom left
3. Use the app

### Elements
 *  **Label**
    * Use `StaticTexts["Name"].label` instead of label
    * *EG*: `XCTAssertEqual(app.staticTexts["TextCopy"].label, "test")`
* **Slider**
    * *EG*: `app.sliders["Completion"].adjust(toNormalizedSliderPosition: 1)`
* **Button**
    * *EG*: `app.buttons["Blue"].tap()`
* **Alert**
    * Exists - `XCTAssertTrue(app.alerts["Blue"].exists)`
    * *Alert Button* - `app.alerts["Blue"].buttons["OK"].tap()`
* **SegmentedControl**
    * Tapping a button on a segmented Control `app.segmentedControls.buttons.element(boundBy: 1).tap()`
* **Navigation**
    * Checking Title - `XCTAssertEqual(app.navigationBars.element.staticTexts.element.label, "Omega")`

### Actions 
* Taps
    * Tap()
    * DoubleTap()
    * TwoFingerTap()
    * Tap(withNumberOfTaps: Int, numberOfTouches:Int)
    * Press(forDuration: Double)
* Gestures
    * SwipeLeft()
    * SwipeRight()
    * Pinch(withScale: Double, velocity: Double)
    * Rotate(_: CGFloat, withVelocity: Double)
* Type Specific
    * Adjust(toPickerWheelValue: String)
    * TypeText()

## Other

* .exits
* .waitForExistence(timeout: Int)
* .element(boundBy: Int)
* .chilren(matching: String)
* .decendants(matching: String)
* .buttons, .alerts ....
* .firstMatch

## Screenshots
Created when fail, but can take other ones
>```
> let screenshot = app.screenshot()
> let attachment = XCTAttachment(screenshot: screenshot)
> attachment.name = "Test"
> attachment.lifetime = .deleteOnSuccess
> add(attachment)