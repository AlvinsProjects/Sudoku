//
//  Globals.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//


import Foundation


struct Globals {
    
    static var bruteForceStop = false
    //---used to store the state of the grid---
    static var actual = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
    static var possible = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    
    static var actualStack = [[Int]]()
    static var possibleStack = [[String]]()
    
    static var totalScore = 0
    static var actualBackup = [[Int]]()
    static var col = 0
    static var row = 0
    
}
    


