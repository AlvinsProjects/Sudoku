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
    var fullBoard = [[Int]]()
    var playerBoard = [[Int]]()
//    var count = 0
    
    init(difficulty: Difficulty = .Medium) {
        self.difficulty = difficulty
        getPuzzle()
        create()
        prepareForPlay()
    }
    
    
    func getPuzzle() {
        
        //---Get the puzzle that is to be solved
        Globals.actual = SelectPuzzle.readSelectedPuzzle()
        
        //---Measure the time it takes to complete a computer solution
        let start = CFAbsoluteTimeGetCurrent()
        
        if !SolvePuzzle.solvePuzzle() {
            print("CRME Solution Failed")
            BruteForce.solvePuzzleByBruteForce()
        }
        
        if SolvePuzzle.solvePuzzle() {
            print("Puzzle Solved using Brute Force")
        }
        
        let executionTime = CFAbsoluteTimeGetCurrent() - start
        Globals.exTime = "\(String(format: "%.4f", executionTime)) secs"
        
        print(Globals.exTime)
        //---Print the solution (for reference)
        print("\nSolution: for \(Globals.puzzName)")
        for j in 0..<9 {
            print(Globals.actual[j])//, Globals.possible[j])  //, playerBoard[j])
        }
        
        if Globals.stepsTakenArray.isEmpty {
            print("There were no solution steps available!")
        }
    }
    
    
    mutating private func create() {
        print("Hello")
        fullBoard = Globals.actual  //The solved puzzle
        playerBoard = Globals.actual
//        print(fullBoard)
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
