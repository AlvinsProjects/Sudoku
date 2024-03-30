//
//  LoneRangers.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/26/24.
//

import Foundation


// ==================================================
//      Look for lone rangers in Minigrids
// ==================================================
func lookForLoneRangersInMinigrids() -> Bool {
    var changes = false
    var nextMiniGrid = false
    var occurrence = 0
    var cPos = 0
    var rPos = 0
    
    // ---check for each number from 1 to 9---
    for n in 0..<9 {
        
        // ---check the 9 mini-grids---
        for r in stride(from: 0, to: 8, by: 3) {
            for c in stride(from: 0, to: 8, by: 3) {
                nextMiniGrid = false
                
                
                // ---check within the mini-grid---
                occurrence = 0
                for rr in 0...2 {
                    for cc in 0...2 {
                        if Variables.actual[c + cc][r + rr] == 0 && Variables.possible[c + cc][r + rr] == String(n) {
                            occurrence += 1
                            cPos = c + cc
                            rPos = r + rr
                            if occurrence > 1 {
                                nextMiniGrid = true
                                break
                            }
                        }
                    }
                    if nextMiniGrid { break }
                }
                
                if !nextMiniGrid && occurrence == 1 {
                    // ---that means number is confirmed---
                    Variables.actual[cPos][rPos] = n
                    changes = true
                    // ---accumulate the total score---
                    Variables.totalScore += 2
                }
            }
        }
    }
    return changes
}


// =========================================================
//            Look for Lone Rangers in Rows
// =========================================================
func lookForLoneRangersInRows() -> Bool  {
    var changes = false
    var occurence = 0
    var cPos = 0
    var rPos = 0

    // ---check by row----
    for r in 0..<9 {
        for n in 0..<9 {
            occurence = 0
            for c in 0..<9 {
                if Variables.actual[c][r] == 0  && Variables.possible[c][r] == String(n)  {
                    occurence += 1
                    //---if multiple occurrence, not a lone ranger anymore
                    if occurence > 1 { break }
                    cPos = c
                    rPos = r
                }
            }
            if occurence == 1 {
                // --number is confirmed---
                if Variables.actual[cPos][rPos] == n {
                    changes = true
                }
                // ---accumulate the total score---
                Variables.totalScore += 2
            }
        }
    }
    return changes
}


// =========================================================
//      Look for Lone Rangers in Columns
// =========================================================
func lookForLoneRangersInColumns() -> Bool {
    var changes = false
    var occurence = 0
    var cPos = 0
    var rPos = 0
    
    // ---check by column----
    for c in 0..<9 {
        for n in 0..<9 {
            occurence = 0
            for r in 0..<9 {
                if Variables.actual[c][r] == 0  && Variables.possible[c][r] == String(n)  {
                    occurence += 1
                    //---if multiple occurrence, not a lone ranger anymore
                    if occurence > 1 { break }
                    cPos = c
                    rPos = r
                }
            }
            if occurence == 1 {
                // --number is confirmed---
                if Variables.actual[cPos][rPos] == n {
                    changes = true
                }
                // ---accumulate the total score---
                Variables.totalScore += 2
            }
        }
    }
    return changes
}
    

