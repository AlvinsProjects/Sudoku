//
//  Globals.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//


import Foundation
import SwiftUI


struct Globals {
    
    //---used to store the state of the grid---
    static var actual = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
    static var possible = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    static var puzzName = "bfEmpty"
    static var bruteForceStop = false
    
    static var actualStack = [[[Int]]]()
    static var possibleStack = [[[String]]]()
    
    static var totalScore = 0
    static var actualBackup = [[Int]]()
    static var exTime = [String]()
    static var GlobePlayers = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    static var bdDifficulty = Board().difficulty
    
    static var stepsTakenArray = [StepsTaken]()
    static var stepsCount = 0
}
    

struct StepsTaken: Identifiable {
    let id = UUID()
    var index: Int
    let steps: String
}
