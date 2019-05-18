//
//  FourAlignedTests.swift
//  FourAlignedTests
//
//  Created by chams on 16/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import XCTest

class FourAlignedTests: XCTestCase {
    
    var board: Board!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        board = Board()
        board.set(chip: .red, atColumn: 0, andRow: 0)
        board.set(chip: .black, atColumn: 1, andRow: 0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testSetChip() {
        
        XCTAssertTrue(board.chip(atColumn: 0, row: 0)! == ChipColor.red)
        XCTAssertTrue(board.chip(atColumn: 1, row: 0)! == ChipColor.black)
    }
    
    func testNextAvailableRow() {
        //let nextAvailableRow = board.nextAvailableRow(fromColumn: 0)
        let row2 = board.nextAvailableRow(fromColumn: 1)
        
        //XCTAssertEqual(1, nextAvailableRow)
        XCTAssertEqual(1, row2)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
