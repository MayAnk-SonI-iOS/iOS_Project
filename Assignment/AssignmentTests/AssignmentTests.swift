//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by mayank soni on 23/12/19.
//  Copyright © 2019 mayank soni. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetailsViewModel(){
        let mDetails = DetailsModel(title : "Test title",description : "tes discription",imageHref : "https://cdn1.iconfinder.com/data/icons/internet-technology-and-security-2/128/77-512.png")
        let mDetailsViewModel = DetailsViewModel(detail: mDetails)
        
        XCTAssert((mDetails.title != nil) , mDetailsViewModel.title!)
        XCTAssert((mDetails.description != nil) , mDetailsViewModel.description1!)
        XCTAssert((mDetails.imageHref != nil) , mDetailsViewModel.imageHref!)
        
    }
    
}
