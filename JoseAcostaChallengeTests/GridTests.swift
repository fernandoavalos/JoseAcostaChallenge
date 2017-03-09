//
//  GridTests.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/8/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import XCTest
@testable import JoseAcostaChallenge

class GridTests: XCTestCase {
    
    let g = Grid([[1,2,3],[4,5,6],[7,8,9]])
    
    func testRowColumnCount() {
        let x = Grid([[1,2,3],[4,5,6]])
        XCTAssertEqual(2, x.rows)
        XCTAssertEqual(3, x.columns)
    }
    
    func testInitAndGetValid() {
        XCTAssertEqual(1, g.get((1,1)))
        XCTAssertEqual(2, g.get((1,2)))
        XCTAssertEqual(3, g.get((1,3)))
        XCTAssertEqual(4, g.get((2,1)))
        XCTAssertEqual(5, g.get((2,2)))
        XCTAssertEqual(6, g.get((2,3)))
        XCTAssertEqual(7, g.get((3,1)))
        XCTAssertEqual(8, g.get((3,2)))
        XCTAssertEqual(9, g.get((3,3)))
    }
    
    func testGetInvalidLowRow() {
        XCTAssertEqual(nil, g.get((0,1)))
    }
    
    func testGetInvalidHighRow() {
        XCTAssertEqual(nil, g.get((4,1)))
    }
    
    func testGetInvalidLowColumn() {
        XCTAssertEqual(nil, g.get((1,0)))
    }
    
    func testGetInvalidHighColumn() {
        XCTAssertEqual(nil, g.get((1,4)))
    }
    
    func testNavigateR1C1Right() {
        XCTAssertTrue((1,2) == g.forward((1,1)))
    }
    
    func testNavigateR2C1Right() {
        XCTAssertTrue((2,2) == g.forward((2,1)))
    }
    
    func testNavigateR3C1Right() {
        XCTAssertTrue((3,2) == g.forward((3,1)))
    }
    
    func testNavigateR1C2Right() {
        XCTAssertTrue((1,3) == g.forward((1,2)))
    }
    
    func testNavigateR2C2Right() {
        XCTAssertTrue((2,3) == g.forward((2,2)))
    }
    
    func testNavigateR3C2Right() {
        XCTAssertTrue((3,3) == g.forward((3,2)))
    }
    
    func testNavigateR1C3Right() {
        XCTAssertTrue(nil == g.forward((1,3)))
    }
    
    func testNavigateR1C1Up() {
        XCTAssertTrue((3,2) == g.up((1,1)))
    }
    
    func testNavigateR2C1Up() {
        XCTAssertTrue((1,2) == g.up((2,1)))
    }
    
    func testNavigateR3C1Up() {
        XCTAssertTrue((2,2) == g.up((3,1)))
    }
    
    func testNavigateR1C2Up() {
        XCTAssertTrue((3,3) == g.up((1,2)))
    }
    
    func testNavigateR2C2Up() {
        XCTAssertTrue((1,3) == g.up((2,2)))
    }
    
    func testNavigateR3C2Up() {
        XCTAssertTrue((2,3) == g.up((3,2)))
    }
    
    func testNavigateR1C3Up() {
        XCTAssertTrue(nil == g.up((1,3)))
    }
    
    func testNavigateR1C1Down() {
        XCTAssertTrue((2,2) == g.down((1,1)))
    }
    
    func testNavigateR2C1Down() {
        XCTAssertTrue((3,2) == g.down((2,1)))
    }
    
    func testNavigateR3C1Down() {
        XCTAssertTrue((1,2) == g.down((3,1)))
    }
    
    func testNavigateR1C2Down() {
        XCTAssertTrue((2,3) == g.down((1,2)))
    }
    
    func testNavigateR2C2Down() {
        XCTAssertTrue((3,3) == g.down((2,2)))
    }
    
    func testNavigateR3C2Down() {
        XCTAssertTrue((1,3) == g.down((3,2)))
    }
    
    func testNavigateR1C3Down() {
        XCTAssertTrue(nil == g.down((1,3)))
    }
}
