//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import XCTest

class AssignmentUITests: XCTestCase {

    var _application: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
         _application = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testUI() {
           
      _application.launch()
             
             let countryTableView = _application.tables["Details_TableView"]
             
             XCTAssertTrue(countryTableView.exists, "TableView is present to display response")
             let tableCells = countryTableView.cells
             
             if tableCells.count > 0 {
                 let count: Int = (tableCells.count - 1)
                 let promise = expectation(description: "Please wait for cell creatons")
                 
                 for index in stride(from: 0, to: count, by: 1) {
                     // Take the first cell and verify that it exists
                     let tableCell = tableCells.element(boundBy: index)
                     
                     XCTAssertTrue(tableCell.exists, "Cell for row \(index) is created")
                     
                     if index == (count - 1) {
                         promise.fulfill()
                     }
                 }
                 waitForExpectations(timeout: 40, handler: nil)
                 XCTAssertTrue(true, "Validation success")
                 
             } else {
                 XCTAssert(false, "table view cells not found")
             }
             
             // Use recording to get started writing UI tests.
             // Use XCTAssert and related functions to verify your tests produce the correct results.
         }

}
