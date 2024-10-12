//
//  SelectPuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/11/24.
//

import Foundation


struct SelectPuzzle: Equatable {
    
    
    static func readSelectedPuzzle(puzIndex: Int) -> [[Int]]  {
        
        let tempInfo = puzArray.SudokuFiles[puzIndex].content
        Globals.puzzName = puzArray.SudokuFiles[puzIndex].name
//        print(Globals.puzzName)
        
        let testInfo = convertZeros(arg: tempInfo)
        print(testInfo)
        
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
//        print(Globals.blanks)
//        for j in 0..<9 {
//            print(testGrid[j])
//        }
        return testGrid
    }
    
    static func convertZeros(arg: String) -> String {
        //    if arg.count != 81 { return "Length of string is not 81" }
        let replaced = arg.replacingOccurrences(of: ".", with: "0")
        return replaced
    }
}


