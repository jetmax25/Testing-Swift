# Chapter 1 Notes

## General Notes
* All tests are run alphebetically
* Use `@testable` to import the project
* No params or return allowed in tests

## Naming

* UnitOfWork_StateUnderTest_ExpectedBehavior]
    > `test_Hater_AfterHavingAGoodDay_ShouldNotBeHating`

* Can disable a test by putting anything before `test` try using `DISABLED_` to make it clear

## Assert Options

* `XCTAssertFalse()`
* `XCTAssertTrue()`
* `XCTAssertEqual()`
* `XCTAssertNotEqual()`
* `XCTAssertGreaterThan()`
* `XCTAssertLessThan()`
* `XCTAssertLessThanOrEqual()`
* `XCTAssertThrowsError()`
* `XCTAssertNoThrow()`
* `XCTAssert()`

Add message to assert to display error 
> XCTAssertFalse(hater.hating, "New Haters should not be hating")`

## Style

1. Arrange
2. Act
3. Assert