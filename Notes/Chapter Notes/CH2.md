# Chapter 2 - Unit Testing

## General Notes
* Don't for get `@testable import` when making a new unit test class
* `sut` is used as the short for "System Under Test" to refer to the object you are testing
* To stop tests after one fails add `continueAfterFailure = false` to the non class `setUp()` override
* **CMD+U**: run all tests
* **Ctrl+Alt+Cmd+U**: Run test where caret is
* **Ctrl+Alt+Cmd+G**: Run last test
* Use UUID for string fields if possible to find outliers
* Do not need to put a passing test, a test is considered passing if it does not fail

## Commonality
* store value in the class (seems like ! is fine here )
    > `var sut: Converter!`
* instantiate in setUp and destroey in teardown

## XCTAssert
use `accuracy` param to give a tolorence level
>` XCTAssertEqual(celsius, 100, accuracy: 0.0001)`

## Tear Down Blocks
use `addTeardownBlock()` to create a test specific teardown 
> ```
> addTeardownBlock {
>    print("In first tearDown block.")
>  }

### Order
1. class setup
2. setup
3. test
4. teardown block
5. teardown
6. class teardown


## Verification
Use a verification method to test for specific values rather than creating multiple tests
Pass in `#line` and `#file` to allow the verification to find the correct place of land
> ```
> func verifyDivision(_ result: (quotient: Int, remainder: Int), expectedQuotient: Int, expectedRemainder: Int, file: StaticString = #file, line: UInt = #line) {
>       XCTAssertEqual(result.quotient, expectedQuotient, file: file, line: line)
> }

## Error Handling

1. Can use XCTFail after a known throw in try catch
    * But it is better to put a success in the known catch

2. Use `XCTAssertThrowsError` error with a throwing statement to assert a failure or `XCTAssertNoThrow` for lack thereof 
    * `XCTAssertThrowsError` gives a closure to test what the actual error is
    >```
    > XCTAssertThrowsError(try game.play()) { error in
    >     XCTAssertEqual(error as? GameError, .notInstalled)
    > }



3. Create a throwing test
    * Make sure to extend LocalizedError to get the description of an error
    >```
    > func testCrashyPlaneDoesntThrow() throws {
    >       let game = Game(name: "CrashyPlane")
    >       try game.play()
    > }

## Async Testing

### General Best Practices
* create a new bundle for async tests
    * File -> New -> Target -> iOS -> Unit Testing Bundle
* try to only run it when needed
    * Scheme -> Edit Scheme -> Test -> Info -> Uncheck Enabled

### Expectations

#### Seting Up Expectations
1. Set Up Expectation Using `XCTestExpectation`
    > `let expectations = XCTestExpectation(description: "Run Some Async Work")`
2. Wait for the epectation using `wait`
    > `wait(for: [expectation], timeout: 10)`
3. fufill the expectation using `.fulfill()`
    > `expectation.fufill()`


#### Properties of Expectations

1. `isInverted` - flips the expectation so that fufuling it is a bad thing
    >`expectation.isInverted = true`
2. `expectedFufillmentCount` - requires that an expectation be fufilled mulitple times
    * Ingored when inverted
    >`expectation.expectedFulfilmentCount = 25`
3. `assetForOverFulfil` - will exit if you fulfill to many times

### Progress

Api called Progress that monitors progress

`XCTNSPredicateExpectation` lets you check progress with a custom string
>`let predicate = NSPredicate(format: %@.completedUnitCount == %@", argumentArray: [progress, maximumCount])`

Wrap in an instance of `XCTNSPredicateExpectation`
>`let expectation = XCTNPredicateExpectation(predicate: predicate: object: progress)`

In your actual methods send back the progress type while still waiting on the completion
> `static func calculate(upTo max: Int, completion: @escaping ([Int]) -> Void) -> Progress`

Using the progress object
>```
>let progress = Progress(totalUnitCount: Int64(max))
>progress.completedUnitCount += 1

### Notifications

`XCTNSNotificationExpectation` is a subclass of `XCTTestCaseExpectation` that allows notification tests

Take the instance of a notification
>`XCTNSNotificationExpectation(name: Notification.Name("SampleNotification"))`

Handle the specifics of a notification by creating a `handler` closure of type `(Notification) -> Bool`
>```
>expectation.handler = { notification -> Bool in
>            guard let level = notification.userInfo?[LinkedInUser.Level.key] as? LinkedInUser.Level else { return false }
>            return level == .gold
>        }

#### General Best Practices 
* Best practice is to pass in a created notification center as a direct injection 
* Remember to remove created notification observers in tear down blocks

### Performance Testing

* Xcode runs performance tests 10 times to get an average

Use `measure` closure to get the peformance of a test
>`measure { _ = PrimeCalculator.calculate(upTo: 1_000_000) } `

After the tests runs click on the grey diamond where you can see the chart of tests. Click on "Set Baseline" to set a base expectation

## Monitoring Tests
* Use the test panel on the Navigator panel
* Can click "x" at the bottom to only show failing tests
* right click failure and press "Jump To Report"

### Code Coverage 
Scheme -> Edit Scheme -> Test -> Options -> Click code coverage -> Run all tests

Go to reports panel in the navigator -> Code coverage

Got To Editor select "Code Coverage" to see what is covered
* Nothing - covered
* Salmon - not covered
* Salmon Strips - partially run

### Random Testing
Scheme -> Edit Scheme -> Test -> Info -> Options (next to test name ) -> Check Randomize Execution Order
### Parallel Testing 
Scheme -> Edit Scheme -> Test -> Info -> Options (next to test name ) -> Check Execute in Parallel
 * Dont use for performance testing
 * Could have collisions
 * CPU usage may slow down