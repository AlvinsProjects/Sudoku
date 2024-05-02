//
//  MiscFuncs.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct BruteForce {
    
    
    /*
    =============================================================
       Find the cell with the smallest number of possible values
    =============================================================*/
    static func findCellWithFewestPossibleValues() -> (col: Int, row: Int) {
        var min = 10
        var col = 0
        var row = 0
        
        for r in 0..<9 {
            for c in 0..<9 {
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count < min {
                    min = Globals.possible[c][r].count
                    col = c
                    row = r
                }
            }
        }
        return (col, row)
    }
    
    
    /*
    ==================================================
          Solve puzzle by Brute Force
    ==================================================*/
    static func solvePuzzleByBruteForce() {
        var c = 0
        var r = 0
        
        // ---accumulate the total score---
        Globals.totalScore += 5
        
        // ---find out which cell has the smallest number of possible values---
        let cellWithMinValues = findCellWithFewestPossibleValues()
        c = cellWithMinValues.col
        r = cellWithMinValues.row
        
        // ---get the possible values for the chosen cell---
        var possibleValues = Globals.possible[c][r]
        
        // ---randomize the possible values----
        possibleValues = randomizeThePossibleValues(str: possibleValues)
        
        // ---push the actual and possible stacks into the stack---
        Globals.actualStack.append(Globals.actual)
        Globals.possibleStack.append(Globals.possible)
        
        //MARK:  Randomize the possible values!!!
        
        // ---select one value and try---
        for i in 0..<possibleValues.count {
            Globals.actual[c][r] = Triplets.getNo(str: possibleValues, item: i)
            
//            print("Brute Force Used")
            Globals.stepsCount += 1
            Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Solved by Brute Force.  Added \(Globals.actual[c][r]) to (\(r), \(c))"))
            
            
            if SolvePuzzle.solvePuzzle() {
                //---if the puzzle is solved, the recursion can stop now---
                Globals.bruteForceStop = true
                break
            } else {
                //---no problem with current selection, proceed with next cell---
                solvePuzzleByBruteForce()
                if Globals.bruteForceStop { break }
            }

            //---accumulate the total score---
            Globals.totalScore += 5
            
            Globals.actual = Globals.actualStack.removeLast()
            Globals.possible = Globals.possibleStack.removeLast()
        }
    }
    
    
    /*
    ==================================================
       Check if the puzzle is solved
    ==================================================*/
    static func isPuzzleSolved() -> Bool {
        var pattern = ""
        
        // ---check row by row---
        for r in 0..<9 {
            pattern = "123456789"
            for c in 0..<9 {
                pattern = pattern.replacingOccurrences(of: String(Globals.actual[c][r]), with: "")
            }
            if pattern.count > 0 {
                return false
            }
        }
        
        // ---check column by column---
        for c in 0..<9 {
            pattern = "123456789"
            for r in 0..<9 {
                pattern = pattern.replacingOccurrences(of: String(Globals.actual[c][r]), with: "")
            }
            if pattern.count > 0 {
                print("Col by Col: pattern: \(pattern),  count = \(pattern.count)")
                return false
            }
        }
        
        // ---check by minigrid---
        for c in stride(from: 0, through: 8, by: 3) {
            pattern = "123456789"
            for r in stride(from: 0, through: 8, by: 3) {
                for cc in 0..<3 {
                    for rr in 0..<3 {
                        pattern = pattern.replacingOccurrences(of: String(Globals.actual[c + cc][r + rr]), with: "")
                    }
                }
            }
            if pattern.count > 0 {
                print("MiniGrid: pattern: \(pattern),  count = \(pattern.count)")
                return false
            }
        }
        return true
    }
    
    
    /*
    =========================================================
        Randomly swap the list of possible values
    =========================================================*/
    static func randomizeThePossibleValues(str: String) -> String {
        var s = [Character]()
        
        for character in str {
            s.append(character)
        }
        s.shuffle()
        let strg = String(s)
        
        return strg
    }
}