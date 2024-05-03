//
//  TestPuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/11/24.
//

import Foundation


struct TestPuzzle: Equatable {
    
    
    static func getTestPuzzle() -> [[Int]]  {
    
        let testInfo = Globals.bfEmpty
        
        var testGrid = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
        var count = 0
        
        //put numbers into the puzzle matrix - use getNo() func
        for col in 0..<9 {
            for row in 0..<9 {
                testGrid[col][row] = Triplets.getNo(str: testInfo, item: count)
                count += 1
            }
        }
        return testGrid
    }
}
