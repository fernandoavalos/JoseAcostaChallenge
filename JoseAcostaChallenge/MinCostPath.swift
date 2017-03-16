//
//  NewSolution.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/15/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import Foundation

class MinCostPath {
    
    
    func min(_ x: Int, _ y: Int, _ z: Int) -> Int {
        if x < y {
            return (x < z ? x : z)
        } else {
            return (y < z ? y : z)
        }
    }
    
    func minPath(_ x: Int, _ y: Int, _ z: Int, _ prevRow: Int, _ maxRow: Int, _ maxColumn: Int) -> Int {
        if x <= y {
            if x <= z {
                return (prevRow == 1 ? maxRow : prevRow - 1)
            } else {
                return (prevRow == maxRow ? 1 : prevRow + 1)
            }
        } else {
            if z <= y {
                return (prevRow == maxRow ? 1 : prevRow + 1)
            } else {
                return prevRow
            }
        }
    }
    
    func minCost(_ matrix: [[Int]], _ mNumRows: Int, _ numCols: Int) -> (Bool, Int, [Int]) {
        var tempCost = Array(repeating: Array(repeating: 0, count: numCols + 1), count: mNumRows + 1)
        
        if mNumRows == 0 && numCols == 0 {
            return (matrix[0][0] <= 50 ? (true, matrix[0][0], [1]) : (false, 0, []))
        } else if numCols == 0 {
            let lowest = lowestCostOn(column: 0, from: matrix)
            return (lowest <= 50 ? (true, matrix[lowest - 1][0], [lowest]) : (false, 0, []))
        }
        
        for index in 0...mNumRows {
            tempCost[index][0] = matrix[index][0]
        }

        for j in 1...numCols {
            for i in 0...mNumRows {
                let x = (i == 0 ? tempCost[mNumRows][j - 1] : tempCost[i - 1][j - 1])
                let y = tempCost[i][j - 1]
                let z = (i == mNumRows ? tempCost[0][j - 1] : tempCost[i + 1][j - 1])
                tempCost[i][j] = min(x, y, z) + matrix[i][j]
            }
        }
        
        var path = Array(repeating: 0, count: numCols + 1)
        
        path[numCols] = lowestCostOn(column: tempCost[0].count - 1, from: tempCost)
        
        var lowestCost = tempCost[path[numCols] - 1][tempCost[0].count - 1]
        
        var wentThrough = false
        if tempCost[path.last! - 1][tempCost[0].count - 1] < 50 {
            wentThrough = true
        }
        
        var counter = 0
        
        for j in (1...numCols).reversed() {
            let x = (path[j] == 1 ? tempCost[mNumRows][j - 1] : tempCost[path[j] - 2][j - 1])
            let y = tempCost[path[j] - 1][j - 1]
            let z = (path[j] == mNumRows + 1 ? tempCost[0][j - 1] : tempCost[path[j]][j - 1])
            
            if !wentThrough && x > 50 && y > 50 && z > 50 {
                counter += 1
            }
            path[j - 1] = minPath(x, y, z, path[j], mNumRows + 1, numCols + 1)
                //minPath(x, y, z, path[j])
        }
        
        if !wentThrough {
            for _ in 0...counter {
                path.removeLast()
            }
            if path.count == 0 {
                lowestCost = 0
            } else {
                lowestCost = tempCost[path.last! - 1][path.count - 1]
            }
            return (wentThrough, lowestCost, path)
        } else {
            return (wentThrough, lowestCost, path)
        }

    }
    
    
    func lowestCostOn(column columnIndex: Int, from tempCost: [[Int]]) -> Int {

        var column = [Int]()
        for i in 0...tempCost.count - 1 {
            
            if let element = tempCost[i].last {
                column.append(element)
            }
        }
        
        var lowest = 0
        
        if !(column.count == 1) {
            for i in 1...column.count - 1 {
                if column[lowest] > column[i] {
                    lowest = i
                }
            }
        }
        
        return lowest + 1
    }
}
