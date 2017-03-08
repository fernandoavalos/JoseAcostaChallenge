//
//  PathSearch.swift
//  JoseAcostaChallenge
//
//  Created by MacDalena on 3/8/17.
//  Copyright © 2017 JoseAcosta. All rights reserved.
//

import Foundation

class PathSearch {
    
    init() {
    }
    
    //Calculates the path of lowest cost from a grid.
    func search(_ grid: [[Int]]) -> (Bool, Int, [Int]) {
        if grid.count < 1 {
            return (false, 0, [])
        }
        
        let g = Grid(grid)
        var lowest: (Bool, Int, [Int])! = nil
        for row in 1...g.rows {
            let rowLowest = searchFrom(g, 0, [], (row, 1))
            if (lowest == nil || rowLowest.1 < lowest.1) {
                lowest = rowLowest
            }
        }
        
        return lowest
    }
    
    //Calculates the lowest path from a given starting point recursively.
    fileprivate func searchFrom(_ g: Grid, _ prevCost: Int, _ prevPath: [Int], _ coords: (Int, Int)) -> (Bool, Int, [Int]) {
        // Add the current point to the previous path.
        let cost = prevCost + g.get(coords)
        let (x, y) = coords
        let path = prevPath + [x]
        
        // Base cases that stop the recursion.
        if cost > 50 {
            return (false, prevCost, prevPath)
        } else if y == g.columns {
            return (true, cost, path)
        }
        
        // Calulate all possible paths from this point.
        let up = searchFrom(g, cost, path, g.up(coords))
        let forward = searchFrom(g, cost, path, g.forward(coords))
        let down = searchFrom(g, cost, path, g.down(coords))
        
        // Choose the least path from this point.
        if betterThan(up, forward) && betterThan(up, down) {
            return up
        } else if betterThan(forward, down) {
            return forward
        } else {
            return down
        }
    }
    
    //Checks if the result on the left is better (lowest path) than the result on the right.
    fileprivate func betterThan(_ left: (Bool, Int, [Int]), _ right: (Bool, Int, [Int])) -> Bool {
        if left.2.count != right.2.count {
            return left.2.count > right.2.count
        } else {
            return left.1 <= right.1
        }
    }
    
}
