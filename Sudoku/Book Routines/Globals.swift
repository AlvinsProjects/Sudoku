//
//  Globals.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//



import Foundation


struct Globals {
    
    //---used to store the state of the grid---
    static var actual = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
    static var possible = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    static var inputPuzzle = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
    static var puzzName = ""
    static var puzIndex = 12
    
    static var puzzle = puzArray.SudokuFiles[puzIndex]  //default blank puzzle
    static var bruteForceStop = false
    
    static var actualStack = [[[Int]]]()
    static var possibleStack = [[[String]]]()
    
    static var totalScore = 0
    static var exTime = [String]()  //save time for each of multiple runs - use first value
    static var GlobePlayers = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    static var bdDifficulty = Board().difficulty
    
    static var stepsTakenArray = [StepsTaken]()
    static var stepsCount = 0
    static var blanks = 0
}
    


struct StepsTaken: Identifiable {
    let id = UUID()
    var index: Int
    let steps: String
}



