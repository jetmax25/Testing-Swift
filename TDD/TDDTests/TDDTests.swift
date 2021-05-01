//
//  TDDTests.swift
//  TDDTests
//
//  Created by Michael Isasi on 4/30/21.
//

import XCTest
@testable import TDD

class TDDTests: XCTestCase {
    func testLoadingImages() {
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.pictures.count, 10, "There should be ten pictures")
    }
    
    func testTableExists() {
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func testTableViewHasCorrectRowCount() {
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, sut.pictures.count)
    }
    
    func testEachCellHasTheCorrectText() {
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        
        for (index, picture) in sut.pictures.enumerated() {
            let indexPath = IndexPath(item: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, picture)
        }
    }
    
    func testCellsHaveDisclosureIndicators() {
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        
        for index in sut.pictures.indices {
            let indexPath = IndexPath(item: index, section: Int.zero)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.accessoryType, .disclosureIndicator)
        }
    }
    
    func testViewControllerUsersLargeTitles() {
        let sut = ViewController()
        _ = UINavigationController(rootViewController: sut)
        
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles ?? false)
    }
    
    func testNavigationBarHasStormViewerTitle() {
        let sut = ViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Storm Viewer")
    }
    
    func testDetailImageViewExists() {
        let sut = DetailViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.imageView)
    }
    
    func testDetailImageViewIsImageView() {
        let sut = DetailViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.view, sut.imageView)
    }
    
    func testDetailLoadsImage() {
        let fileNameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: fileNameToTest, in: Bundle.main, with: nil)
        XCTAssertNotNil(imageToLoad)
        let sut = DetailViewController()
        
        sut.selectedImage = fileNameToTest
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.imageView.image, imageToLoad)
    }
    
    //Integration Test
    func testSelectingImageShowsDetail() {
        let sut = ViewController()
        var selectedImage: String?
        
        let testIndexPath = IndexPath(row: Int.zero, section: Int.zero)
        
        sut.pictureSelectAction = {
            selectedImage = $0
        }
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
        
        XCTAssertEqual(selectedImage, "nssl0049.jpg")
    }
    
    func testSelectingImageShowsDetailImage() {
        let sut = ViewController()
        let testIndexPath = IndexPath(row: Int.zero, section: Int.zero)
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)
        
        sut.pictureSelectAction = {
            let detail = DetailViewController()
            detail.selectedImage = $0
            detail.loadViewIfNeeded()
            
            XCTAssertEqual(detail.imageView.image, imageToLoad)
        }
        
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
    }
}
