//
//  TestingSwiftTests.swift
//  TestingSwiftTests
//
//  Created by Michael Isasi on 4/28/21.
//

import XCTest
@testable import TestingSwift

class TestingSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHaterStartsNicely() {
        let hater = Hater()
        XCTAssertFalse(hater.hating)
    }
    
    func testHaterHatesAfterBadDay() {
        var hater = Hater()
        hater.hadABadDay()
        XCTAssertTrue(hater.hating)
    }
    
    func testHaterHappyAfterGoodDay() {
        var hater = Hater()
        hater.hadAGoodDay()
        XCTAssertFalse(hater.hating)
    }
    
    func createTestUser(projects: Int, itemsPerProject: Int) -> User {
        let user = User(name: UUID().uuidString)
        XCTAssertEqual(user.projects.count, 0)
        
        for album in 1...projects {
            let project = Project(name: "Album #\(album)")
            XCTAssertEqual(project.toDoItems.count, 0)
            user.add(project: project)
            
            for song in 1...itemsPerProject {
                let item = ToDoItem(name: "Write song #\(song)")
                project.add(item: item)
            }
        }
        return user
    }
    
    func verifyUser(_ user: User, expectedProjectCount: Int, expectedTaskCount: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(user.projects.count, expectedProjectCount, file: file, line: line)
        XCTAssertEqual(user.numTasks, expectedTaskCount, file: file, line: line)
    }
    
    func testUserHasCorrectProjectCount() {
        let numProjects = 3
        let itemsPerProject = 10
        
        let sut = createTestUser(projects: numProjects, itemsPerProject: itemsPerProject)
        
        verifyUser(sut, expectedProjectCount: numProjects, expectedTaskCount: numProjects * itemsPerProject)
    }
    
    func testUserAddsAllProjectsAndItems() {
        let numProjects = 3
        let itemsPerProject = 10
        let sut = createTestUser(projects: numProjects, itemsPerProject: itemsPerProject)
        
        let rowTitle = sut.outstandingTasksString
    
        verifyUser(sut, expectedProjectCount: numProjects, expectedTaskCount: numProjects * itemsPerProject)
        XCTAssertEqual(rowTitle, "30 Items")
    }

}
