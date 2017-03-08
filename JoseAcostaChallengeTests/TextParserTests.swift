//
//  JoseAcostaChallengeTests.swift
//  JoseAcostaChallengeTests
//
//  Created by MacDalena on 3/7/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import XCTest
@testable import JoseAcostaChallenge

class TextParserTest: XCTestCase {
    
    var out: TextParser!
    
    override func setUp() {
        super.setUp()
        out = TextParser()
    }
    
    func testEmptyInput() {
        XCTAssertEqual(0, out.parse("").count)
    }
    
    func testSingleValue() {
        let matrix: [[Int]] = [[1]]
        XCTAssertEqual(matrix[0], out.parse("1")[0])
    }
    
    func testSingleRow() {
        let matrix: [[Int]] = [[1,2,3]]
        XCTAssertEqual(matrix[0], out.parse("1 2 3")[0])
    }
    
    func testTwoRows() {
        let matrix: [[Int]] = [[1,2,3],[4,5,6]]
        XCTAssertEqual(matrix[0], out.parse("1 2 3\n4 5 6")[0])
        XCTAssertEqual(matrix[1], out.parse("1 2 3\n4 5 6")[1])
    }
    
    func testThreeRows() {
        let matrix: Array<Array<Int>> = [[1,2,3],[4,5,6],[7,8,9]]
        XCTAssertEqual(matrix[0], out.parse("1 2 3\n4 5 6\n7 8 9")[0])
        XCTAssertEqual(matrix[1], out.parse("1 2 3\n4 5 6\n7 8 9")[1])
        XCTAssertEqual(matrix[2], out.parse("1 2 3\n4 5 6\n7 8 9")[2])
    }
}
