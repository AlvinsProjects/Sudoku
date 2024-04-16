//
//  Board.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import Foundation



struct Board: Equatable {
    
    enum Difficulty: Int, CaseIterable {
//        #if DEBUG
//        case Testing = 2
//        #endif
        case Trivial = 10
        case Easy = 20
        case Medium = 24
        case Hard = 27
        case Extreme = 29
    }
    
    
    let size = 9
    let difficulty: Difficulty
    var fullBoard = [[Int]]()
    var playerBoard = [[Int]]()
    
    init(difficulty: Difficulty = .Trivial) {
        self.difficulty = difficulty
        create()
        prepareForPlay()
        
        
        //MARK: Call the Sudoku Program
//        let result = GeneratePuzzle.getPuzzle(level: 4)
        Globals.actual = TestPuzzle.getTestPuzzle()

        let start = CFAbsoluteTimeGetCurrent()
        // run your work
        
        let testResult = SolvePuzzle.solvePuzzle()
        print(testResult)
        
        let diff = CFAbsoluteTimeGetCurrent() - start

        print("Execution Time:  \(String(format: "%.4f", diff)) secs")
        
        print("Solution:\n")
        for j in 0..<9 {
            print(Globals.actual[j])
        }
        


    }
    
    
    mutating private func create() {
        let numbers = Array(1...size).shuffled()
        let positions = [0, 3, 6, 1, 4, 7, 2, 5, 8]
        
        let rows = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(), 
                          [6, 7, 8].shuffled()].shuffled()).joined()
        
        let columns = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(),
                             [6, 7, 8].shuffled()].shuffled()).joined()
        for row in rows {
            var newRow = [Int]()
            
            for column in columns {
                let position = (positions[row] + column) % size
                newRow.append(numbers[position])
            }
            fullBoard.append(newRow)
        }
        playerBoard = fullBoard
    }
    
    
    mutating private func prepareForPlay() {
        let empties = difficulty.rawValue
        let allCells = 0..<Int(ceil(Double(size * size) / 2))
        
        for cell in allCells.shuffled().prefix(upTo: empties) {
            let row = cell / size
            let column = cell % size
            playerBoard[row][column] = 0
            playerBoard[8 - row][8 - column] = 0
        }
    }
    
    
    
    
    
//    let testGrid = [[1, 2, 3],
//                    [4, 5, 6],
//                    [7, 8, 9]]
//    
//    let testInfo = "034000090600008214001027000409083050560000087020560401000210800857900006090000340"
}
