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
    
    
    var _jsonResponseModel: JSResponse!
    var _detailsModel: DetailsModel!
    
    var _detailsRowVM: DetailsRowViewModel!
    var _detailsVM: DetailsViewModel!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        _jsonResponseModel = JSResponse.init(title: "The XYZ", rows: [DetailsModel.init(title: "the ABC", description: "NO description", imageHref: "")])
        
        _detailsVM = DetailsViewModel.init(pJsonResponse: _jsonResponseModel)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetailsViewModel() {
        
        XCTAssertNotNil(_detailsVM, "Response VIew model")
        
        XCTAssertTrue(_detailsVM.detailsModel?.title == _detailsVM.title, "Response View model title is no correct" )
        
        XCTAssertTrue(_detailsVM.detailsModel?.rows.count == _detailsVM.rows.count, "Response rows array count is not correct" )
        
    }
    
    
}
