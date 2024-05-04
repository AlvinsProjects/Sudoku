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
        getPuzzle()
        create()
        prepareForPlay()
    }
    
    
    func getPuzzle() {
        
        //---Get the puzzle that is to be tested
        Globals.actual = TestPuzzle.getTestPuzzle()
        
        //---Measure the time it takes to complete a solution
        let start = CFAbsoluteTimeGetCurrent()
        
        if SolvePuzzle.solvePuzzle() {
            print("\nPuzzle Solved")
        } else {
            print("CRME Solution Failed")
            BruteForce.solvePuzzleByBruteForce()
            if SolvePuzzle.solvePuzzle() {
                print("Puzzle Solved using Brute Force")
            }
        }
        
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Execution Time:  \(String(format: "%.4f", diff)) secs")
        
        //---Print the solution (for reference)
        print("\nSolution:")
        for j in 0..<9 {
            print(Globals.actual[j]) //, Globals.possible[j])
        }
        
        if Globals.stepsTakenArray.isEmpty {
            print("There were no solution steps available!")
        } //else {
//            for item in Globals.stepsTakenArray {
//                if item.index < 10 {
//                    print("\(item.index)  \(item.steps)")
//                } else {
//                    print("\(item.index) \(item.steps)")
//                }
//            }
//        }
    }
    
    
    mutating private func create() {
        //MARK: Paul Hudson's code
//        let numbers = Array(1...size).shuffled()
//        let positions = [0, 3, 6, 1, 4, 7, 2, 5, 8]
//        
//        let rows = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(), 
//                          [6, 7, 8].shuffled()].shuffled()).joined()
//        
//        let columns = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(),
//                             [6, 7, 8].shuffled()].shuffled()).joined()
//        for row in rows {
//            var newRow = [Int]()
//            
//            for column in columns {
//                let position = (positions[row] + column) % size
//                newRow.append(numbers[position])
//            }
//            fullBoard.append(newRow)
//        }
//        fullBoard = TestPuzzle.getTestPuzzle()
        
        fullBoard = Globals.actual  //The solved puzzle
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
}
