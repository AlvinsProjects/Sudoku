//
//  SelectPuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/11/24.
//

import Foundation


struct SelectPuzzle: Equatable {
    
    
    static func readSelectedPuzzle() -> [[Int]]  {
        
        let name = Globals.puzzle.name
        
        let testInfo = puzArray.SudokuFiles[Globals.puzIndex].content
        Globals.puzzName = name  //puzArray.SudokuFiles[puzIndex].name
        
        var testGrid = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
        var count = 0
        Globals.blanks = 0
        
        //put numbers into the puzzle matrix - use getNo() func
        for col in 0..<9 {
            for row in 0..<9 {
                testGrid[col][row] = Triplets.getNo(str: testInfo, item: count)
                count += 1
                
                if testGrid[col][row] == 0 {
                    Globals.blanks += 1
                }
            }
        }
        print(Globals.blanks)
//        for j in 0..<9 {
//            print(testGrid[j])
//        }
        return testGrid
    }
}

