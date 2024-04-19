//
//  TestPuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/11/24.
//

import Foundation


struct TestPuzzle: Equatable {
    
    
    static func getTestPuzzle() -> [[Int]]  {
        
        var testGrid = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
        
        // CRME (Column, Row, MiniGrid Elimination) puzzles
//        let testInfo = "400280010609430500070050040300840000097103480000092006080010070002079804050028001"
//        let testInfo = "034000090600008214001027000409083050560000087020560401000210800857900006090000340"
//        let testInfo = "005400180146080500070013000451008706080000010603700948000390070004070269019006400"

        // Lone Rangers
//        let testInfo = "409856700007402680508007004705060000604203500380070006056941000900028050200000008" // Chap4-Eg1
        let testInfo = "080000109640001037070830000701003040005000083400605000900062008010009000024708500" //Chap4-Eg2
        
        var count = 0
        
        func getTest(item: Int) -> Int {
            Int(String(testInfo[testInfo.index(testInfo.startIndex, offsetBy: item)])) ?? 999
        }
        
        //put numbers into the puzzle matrix
        for col in 0..<9 {
            for row in 0..<9 {
                testGrid[col][row] = (getTest(item: count))
                count += 1
            }
        }
        return testGrid
    }
}
