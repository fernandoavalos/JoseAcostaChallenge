//
//  PathSearcTests.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/8/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import XCTest
@testable import JoseAcostaChallenge

class PathSearcTests: XCTestCase {
    var out: PathSearch!
    
    override func setUp() {
        super.setUp()
        out = PathSearch()
    }
    
    func testWhenEmptyInputReturnNil() {
        let (success, cost, path) = out.search([])
        XCTAssertFalse(success)
        XCTAssertEqual(0, cost)
        XCTAssertEqual([], path)
    }
    
    func testWhenSingleRowSingleColumnInput() {
        let (success, cost, path) = out.search([[4]])
        XCTAssertTrue(success)
        XCTAssertEqual(4, cost)
        XCTAssertEqual([1], path)
    }
    
    func testWhenSingleRowSingleColumnInput2() {
        let (success, cost, path) = out.search([[8]])
        XCTAssertTrue(success)
        XCTAssertEqual(8, cost)
        XCTAssertEqual([1], path)
    }
    
    func testWhenSingleRowMultipleColumnInput() {
        let (success, cost, path) = out.search([[1,2,3,4]])
        XCTAssertTrue(success)
        XCTAssertEqual(10, cost)
        XCTAssertEqual([1,1,1,1], path)
    }
    
    func test2RowInput1() {
        let (success, cost, path) = out.search([[1,2],[3,4]])
        XCTAssertTrue(success)
        XCTAssertEqual(3, cost)
        XCTAssertEqual([1,1], path)
    }
    
    func test2RowInput2() {
        let (success, cost, path) = out.search([[3,4],[1,2]])
        XCTAssertTrue(success)
        XCTAssertEqual(3, cost)
        XCTAssertEqual([2,2], path)
    }
    
    func test2RowInput3() {
        let (success, cost, path) = out.search([[1,4],[3,2]])
        XCTAssertTrue(success)
        XCTAssertEqual(3, cost)
        XCTAssertEqual([1,2], path)
    }
    
    func test2RowInput4() {
        let (success, cost, path) = out.search([[1,2,1,2,1],[2,1,2,1,2]])
        XCTAssertTrue(success)
        XCTAssertEqual(5, cost)
        XCTAssertEqual([1,2,1,2,1], path)
    }
    
    func test3RowInput1() {
        let (success, cost, path) = out.search([[1,2,3,2,1],[2,1,2,1,2],[4,4,1,4,4]])
        XCTAssertTrue(success)
        XCTAssertEqual(5, cost)
        XCTAssertEqual([1,2,3,2,1], path)
    }
    
    func testGivenExample1() {
        let (success, cost, path) = out.search([
            [3,4,1,2,8,6],
            [6,1,8,2,7,4],
            [5,9,3,9,9,5],
            [8,4,1,3,2,6],
            [3,7,2,8,6,4]
            ])
        XCTAssertTrue(success)
        XCTAssertEqual(16, cost)
        XCTAssertEqual([1,2,3,4,4,5], path)
    }
    
    func testGivenExample2() {
        let (success, cost, path) = out.search([
            [3,4,1,2,8,6],
            [6,1,8,2,7,4],
            [5,9,3,9,9,5],
            [8,4,1,3,2,6],
            [3,7,2,1,2,3]
            ])
        XCTAssertTrue(success)
        XCTAssertEqual(11, cost)
        XCTAssertEqual([1,2,1,5,4,5], path)
    }
    
    func testGivenExample3() {
        let (success, cost, path) = out.search([
            [19,10,19,10,19],
            [21,23,20,19,12],
            [20,12,20,11,10]
            ])
        XCTAssertFalse(success)
        XCTAssertEqual(48, cost)
        XCTAssertEqual([1,1,1], path)
    }
    
    func testGivenExample4() {
        let (success, cost, path) = out.search([
            [51,3,3,6],
            [6,3,7,9],
            [5,6,8,3]
            ])
        XCTAssertTrue(success)
        XCTAssertEqual(14, cost)
        XCTAssertEqual([3,2,1,3], path)
    }
    
    func testGivenExample5() {
        let (success, cost, path) = out.search([
            [5],
            [8],
            [5],
            [3],
            [5]
            ])
        XCTAssertTrue(success)
        XCTAssertEqual(3, cost)
        XCTAssertEqual([4], path)
    }
    
    func testGivenExample6() {
        let (success, cost, path) = out.search([
            [69,10,19,10,19],
            [51,23,20,19,12],
            [60,12,20,11,10]
            ])
        XCTAssertFalse(success)
        XCTAssertEqual(0, cost)
        XCTAssertEqual([], path)
    }
}
