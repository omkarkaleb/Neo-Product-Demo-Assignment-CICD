//
//  Neo_Product_Demo_AssignmentTests.swift
//  Neo Product Demo AssignmentTests
//
//  Created by Neosoft on 10/02/22.
//

import XCTest
@testable import Neo_Product_Demo_Assignment

class Neo_Product_Demo_AssignmentTests: XCTestCase {
    
    var Like_Check_Service = LikeChecker()
    
    override func setUp() {
        Like_Check_Service = LikeChecker()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_is_valid_ID() throws {
        XCTAssertNoThrow(try Like_Check_Service.createItem(id: 0))
        XCTAssertNoThrow(try Like_Check_Service.deleteItem(id: 4))
    }

}
