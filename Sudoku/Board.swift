//
//  Board.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import Foundation


struct Board: Equatable {
    
    enum Difficulty: Int, CaseIterable {
        case Trivial = 10
        case Easy    = 20
        case Medium  = 24
        case Hard    = 27
        case Extreme = 29
    }
    
    
    let size = 9
    let difficulty: Difficulty
    var fullBoard = [[Int]]()       //board with full solution
    var playerBoard = [[Int]]()     //changes as numbers are added
    var pencilBoard = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))  //board with pencil marks
    
    
    init(difficulty: Difficulty = .Easy) {
        self.difficulty = difficulty
        getPuzzle()
        create()
        if Globals.puzIndex == 54 {  //Blank puzzle for brute force solution
            prepareForPlay()
        }
        //        prepareForPlay()
    }
    
    
    func getPuzzle() {
        
        ClearPuzzle().clearPreviousPuzzle()                                                                                         
        
        //---Get the puzzle that is to be solved
        let puzIndex = Globals.puzIndex
        Globals.actual = SelectPuzzle.readSelectedPuzzle(puzIndex: puzIndex)
        Globals.inputPuzzle = Globals.actual
        
        //MARK: Test Print
        //                print(Globals.actual[0])
        //                print(Globals.inputPuzzle[0])
        //        Globals.blanks = 999
        
        //Measure the time it takes to complete a computer solution
        let start = CFAbsoluteTimeGetCurrent()
        
        if SolvePuzzle.solvePuzzle() {
            print("Puzzle Solved using CRME methods")
        } else {
            BruteForce.solvePuzzleByBruteForce()
            print("Puzzle Solved using Brute Force")
        }
        
        
        let executionTime = CFAbsoluteTimeGetCurrent() - start
        Globals.exTime.append("\(String(format: "%.4f", executionTime)) secs")
        
        print("Execution Time: \(Globals.exTime[0]) secs")
        
        //---Print the solution (for reference)
        print("\nSolution for \(Globals.puzzName), Index: \(Globals.puzIndex)")
        for j in 0..<9 {
            print(Globals.actual[j])
        }
        
        if Globals.stepsTakenArray.isEmpty {
            print("There were no solution steps available!")
        }
        
        //        print(Globals.stepsTakenArray)
    }
    
    
    mutating private func create() {
        fullBoard = Globals.actual  //The solved puzzle
        
        if Globals.puzIndex == 54 { //Blank puzzle for brute force solution
            playerBoard = Globals.actual
        } else {
            playerBoard = Globals.inputPuzzle
            print("not 54")
        }
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
    
    


//    mutating private func create() {
//        let numbers = Array(1...size).shuffled()
//        let positions = [0, 3, 6, 1, 4, 7, 2, 5, 8]
//        
//        let rows = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(), [6, 7, 8].shuffled()].shuffled()).joined()
//        let columns = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(), [6, 7, 8].shuffled()].shuffled()).joined()
//        
//        for row in rows {
//            var newRow = [Int]()
//            
//            for column in columns {
//                let position = (positions[row] + column) % size
//                newRow.append(numbers[position])
//            }
//            fullBoard.append(newRow)
//        }
//        playerBoard = fullBoard
//    }












    
//    func printSolution() {
//        //---Print the solution (for reference)
//        print("\nSolution: for \(Globals.puzzName)")
//        for j in 0..<9 {
//            print(Globals.actual[j])  //, playerBoard[j])
//        }
//    }
    
    
    
    
//    mutating func getNewPuzzle() {
//        getPuzzle()
//        create()
//        prepareForPlay()
//    }
//}
