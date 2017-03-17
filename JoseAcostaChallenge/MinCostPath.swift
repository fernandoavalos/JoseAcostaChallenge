//
//  NewSolution.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/15/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import Foundation

class MinCostPath {
    
    func min(_ x: Int?, _ y: Int?, _ z: Int?) -> Int? {
        if let x = x {
            if let y = y {
                if let z = z {
                    if x < y {
                        if x < z {
                            return (x > 50 ? nil : x)
                        } else {
                            return (z > 50 ? nil : z)
                        }
                    } else if y < z {
                        return (y > 50 ? nil : y)
                    } else {
                        return (z > 50 ? nil : z)
                    }
                } else if x < y {
                    return (x > 50 ? nil : x)
                } else {
                    return (y > 50 ? nil : y)
                }
            } else if let z = z {
                if x < z {
                    return (x > 50 ? nil : x)
                } else {
                    return (z > 50 ? nil : z)
                }
            } else {
                return (x > 50 ? nil : x)
            }
        } else if let y = y {
            if let z = z {
                if y < z {
                    return (y > 50 ? nil : y)
                } else {
                    return (z > 50 ? nil : z)
                }
            } else {
                return (y > 50 ? nil : y)
            }
        } else if let z = z {
            return (z > 50 ? nil : z)
        } else {
            return nil
        }
        
    }
    
    func minPath(_ x: Int?, _ y: Int?, _ z: Int?, _ prevRow: Int, _ maxRow: Int, _ maxColumn: Int) -> Int? {
        
        if let x = x {
            if let y = y {
                if let z = z {
                    if x <= y {
                        if x <= z {
                            return (prevRow == 1 ? maxRow : prevRow - 1) //x
                        } else {
                            return (prevRow == maxRow ? 1 : prevRow + 1) //z
                        }
                    } else if y <= z {
                        return prevRow                               //y
                    } else {
                        return (prevRow == maxRow ? 1 : prevRow + 1) //z
                    }
                } else if x < y {
                    return (prevRow == 1 ? maxRow : prevRow - 1) //x
                } else {
                    return prevRow                               //y
                }
            } else if let z = z {
                if x < z {
                    return (prevRow == 1 ? maxRow : prevRow - 1) //x
                } else {
                    return (prevRow == maxRow ? 1 : prevRow + 1) //z
                }
            } else {
                return (prevRow == 1 ? maxRow : prevRow - 1) //x
            }
        } else if let y = y {
            if let z = z {
                if y < z {
                    return prevRow                               //y
                } else {
                    return (prevRow == maxRow ? 1 : prevRow + 1) //z
                }
            } else {
                return prevRow                               //y
            }
        } else if let _ = z {
            return (prevRow == maxRow ? 1 : prevRow + 1) //z
        } else {
            return nil
        }
        
    }
    
    func minCost(_ matrix: [[Int]], _ mNumRows: Int, _ numCols: Int) -> (Bool, Int, [Int]) {
        var tempCost: [[Int?]] = Array(repeating: Array(repeating: 0, count: numCols + 1), count: mNumRows + 1)
        
        if mNumRows == 0 && numCols == 0 {
            return (matrix[0][0] <= 50 ? (true, matrix[0][0], [1]) : (false, 0, []))
        } else if numCols == 0 {
            let lowestSucces = lowestCostOn(column: 0, from: matrix)
            if lowestSucces.0 == true {
                return (lowestSucces.1 <= 50 ? (true, matrix[lowestSucces.1 - 1][0], [lowestSucces.1]) : (false, 0, []))
            } else {
                return (false, 0, [])
            }
            
        }
        
        //Build the first column on tempCost Array
        for index in 0...mNumRows {
            tempCost[index][0] = matrix[index][0]
        }
        
        //Build the rest of tempCost Array
        for j in 1...numCols {
            for i in 0...mNumRows {
                let x = (i == 0 ? tempCost[mNumRows][j - 1] : tempCost[i - 1][j - 1])
                let y = tempCost[i][j - 1]
                let z = (i == mNumRows ? tempCost[0][j - 1] : tempCost[i + 1][j - 1])
                if let minimum = min(x, y, z) {
                    tempCost[i][j] = (minimum + matrix[i][j] > 50 ? nil : minimum + matrix[i][j])
                } else{
                    tempCost[i][j] = nil
                }
                
            }
        }
        
        
        //Get the lowest cost on last succesful column
        var path = Array(repeating: 0, count: numCols + 1)
        var lowestSucces = (false, 0)
        var lowestCost = 0
        for item in (0...tempCost[0].count - 1).reversed() {
            lowestSucces = lowestCostOn(column: item, from: tempCost)
            if lowestSucces.0 == true {
                path[item] = lowestSucces.1
                lowestCost = tempCost[path[item] - 1][item]!
                if item == 0 {
                    return (item == numCols + 1 ? (true, lowestCost, path) : (false, lowestCost, path))
                }
                break
            } else if item == 0 {
                return (false, 0, [])
            } else{
                path.removeLast()
            }
        }
        
        var wentThrough = false
        if path.count == tempCost[0].count && tempCost[path.last! - 1][tempCost[0].count - 1]! <= 50 {
            wentThrough = true
        }
        
        //MUST BE 1...
        for j in (1...(path.count - 1)).reversed() {
            let x = (path[j] == 1 ? tempCost[mNumRows][j - 1] : tempCost[path[j] - 2][j - 1])
            let y = tempCost[path[j] - 1][j - 1]
            let z = (path[j] == mNumRows + 1 ? tempCost[0][j - 1] : tempCost[path[j]][j - 1])
            
            path[j - 1] = minPath(x, y, z, path[j], mNumRows + 1, numCols + 1)!
        }
        
        return (wentThrough, lowestCost, path)

    }
    
    //Get the lowest cost of desired column
    func lowestCostOn(column columnIndex: Int, from tempCost: [[Int?]]) -> (Bool, Int) {
        //Get the last column
        var column = [Int?]()
        for i in 0...tempCost.count - 1 {
            column.append(tempCost[i][columnIndex])
        }
        
        var lowest = 0
        
        if column.count == 1 {
            if let item = column[lowest] {
                return (item > 50 ? (false, 0) : (true, lowest + 1))
            } else {
                return (false, 0)
            }
        } else if !(column.count == 1) {
            for i in 1...column.count - 1 {
                if let prevLow = column[lowest] {
                    if let nextLow = column[i] {
                        lowest = (prevLow > nextLow ? i : lowest)
                        if i == column.count - 1  && column[lowest]! > 50{
                            return (false, 0)
                        }
                    }
                } else {
                    if let _ = column[i] {
                        lowest = i
                    } else if i == column.count - 1 {
                        return (false, 0)
                    } else {
                        lowest += 1
                    } 
                }
            }
        }
        
        return (true, lowest + 1)
    }
}
