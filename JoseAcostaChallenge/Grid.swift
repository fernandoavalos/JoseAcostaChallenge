//
//  Grid.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/8/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import Foundation

class Grid {
    
    var matrix: [[Int]]!
    
    init(_ matrix: [[Int]]) {
        self.matrix = matrix
    }
    
    var rows: Int {
        return matrix.count
    }
    
    var columns: Int {
        return matrix[0].count
    }
    
    //Returns the lowest cost at the given coordinates.
    
    func get(_ coords: (Int, Int)) -> Int! {
        let (x, y) = coords
        if x <= 0 || x > matrix.count || y <= 0 || y > matrix[0].count {
            return nil
        }
        return matrix[x - 1][y - 1]
    }
    
    
    //Moves forward and returns the new point.
    
    func forward(_ coords: (Int, Int)) -> (Int, Int)! {
        let (x, y) = coords
        if y >= matrix[0].count {
            return nil
        }
        return (x, y + 1)
    }
    
    
    //Moves upward and returns the new point.
    
    func up(_ coords: (Int, Int)) -> (Int, Int)! {
        let (x, y) = coords
        if y >= matrix[0].count {
            return nil
        }
        return (x == 1 ? matrix.count : x - 1, y + 1)
    }
    
    
    //Moves downward and returns the new point.
    
    func down(_ coords: (Int, Int)) -> (Int, Int)! {
        let (x, y) = coords
        if y >= matrix[0].count {
            return nil
        }
        return (x == matrix.count ? 1 : x + 1, y + 1)
    }
}
