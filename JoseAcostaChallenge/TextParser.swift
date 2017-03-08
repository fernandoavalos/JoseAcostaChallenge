//
//  TextParser.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/8/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import Foundation

class TextParser {
    
    init() {
    }
    
    func parse(_ input: String) -> Array<Array<Int>> {
        var matrix: Array<Array<Int>> = []
        
        let rowStrings = input.components(separatedBy: "\n")
        for rowString in rowStrings {
            if rowString.isEmpty {
                break
            }
            let colStrings = rowString.components(separatedBy: " ")
            matrix.append(colStrings.map() { x in Int(x) ?? 0 })
        }
        
        // Validate all rows must have the same number of columns
        var width: Int!
        for row in matrix {
            width = width ?? row.count
            if row.count != width {
                fatalError("All rows must have the same number of columns")
            }
        }
        
        return matrix
    }

}
