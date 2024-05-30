//
//  TestPuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/11/24.
//

import Foundation


struct TestPuzzle: Equatable {
    
    
    static func getTestPuzzle() -> [[Int]]  {
    
//        GeneratePuzzle().generateNewPuzzle()
//        let puzIndex = Globals.puzzle.number
        let name = Globals.puzzle.name
//        let cont = Globals.puzzle.content
//        print(puzIndex, name, cont)
        let testInfo = puzArray.SudokuFiles[Globals.puzIndex].content
        Globals.puzzName = name  //puzArray.SudokuFiles[puzIndex].name
        
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

