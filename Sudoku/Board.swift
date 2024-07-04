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
        case Easy = 20
        case Medium = 24
        case Hard = 27
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
        if Globals.puzIndex == 12 {  //Blank puzzle for brute force solution
            prepareForPlay()
        }
    }
    
    
    func getPuzzle() {
        
        //---Get the puzzle that is to be solved
        Globals.actual = SelectPuzzle.readSelectedPuzzle()
        Globals.inputPuzzle = Globals.actual

        //---Measure the time it takes to complete a computer solution
        let start = CFAbsoluteTimeGetCurrent()
        
        if !SolvePuzzle.solvePuzzle() {
            BruteForce.solvePuzzleByBruteForce()
            print("Puzzle Solved using Brute Force")
        }
        
        let executionTime = CFAbsoluteTimeGetCurrent() - start
        Globals.exTime.append("\(String(format: "%.4f", executionTime)) secs")
//        print(Globals.totalScore)
//        print(Globals.exTime)
        //---Print the solution (for reference)
//        print("\nSolution for \(Globals.puzzName), Index: \(Globals.puzIndex)")
//        for j in 0..<9 {
//            print(Globals.actual[j])
//        }
        
        if Globals.stepsTakenArray.isEmpty {
            print("There were no solution steps available!")
        }
    }
    
    
    mutating private func create() {
        fullBoard = Globals.actual  //The solved puzzle
        
        if Globals.puzIndex == 12 { //Blank puzzle for brute force solution
            playerBoard = Globals.actual
        } else {
            playerBoard = Globals.inputPuzzle
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
}
