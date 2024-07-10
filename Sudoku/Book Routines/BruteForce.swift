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
        
        // ---select one value and try---
        for i in 0..<possibleValues.count {
            Globals.actual[c][r] = Triplets.getNo(str: possibleValues, item: i)
            
            Globals.stepsCount += 1
            Globals.stepsTakenArray.append(
                StepsTaken(index: Globals.stepsCount,
                           steps: "Solved by Brute Force.  Added \(Globals.actual[c][r]) to (\(r), \(c))"))
            
            
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
    =========================================================
        Randomly swap the list of possible values
    =========================================================*/
    static func randomizeThePossibleValues(str: String) -> String {
        var s = [Character]()
        
        for character in str {
            s.append(character)
        }
        s.shuffle()
        let strg = String(s.shuffled())
        return strg
    }
}
