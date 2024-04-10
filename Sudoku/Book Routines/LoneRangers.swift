//
//  LoneRangers.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/26/24.
//

import Foundation


struct LoneRangers  {
    
    
    /*
    ==================================================
          Look for lone rangers in Minigrids
    ==================================================*/
    static func lookForLoneRangersInMinigrids() -> Bool {
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
                    for rr in 0..<3 {
                        for cc in 0..<3 {
                            if Globals.actual[c + cc][r + rr] == 0 &&
                                Globals.possible[c + cc][r + rr].contains(String(n)) {
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
                        Globals.actual[cPos][rPos] = n
                        changes = true
                        // ---accumulate the total score---
                        Globals.totalScore += 2
                    }
                }
            }
        }
        return changes
    }
    
    
    /*
    =========================================================
                Look for Lone Rangers in Rows
    =========================================================*/
    static func lookForLoneRangersInRows() -> Bool  {
        var changes = false
        var occurence = 0
        var cPos = 0
        var rPos = 0
        
        // ---check by row----
        for r in 0..<9 {
            for n in 0..<9 {
                occurence = 0
                for c in 0..<9 {
                    if Globals.actual[c][r] == 0  && 
                        Globals.possible[c][r].contains(String(n))  {
                        occurence += 1
                        //---if multiple occurrence, not a lone ranger anymore
                        if occurence > 1 { break }
                        cPos = c
                        rPos = r
                    }
                }
                if occurence == 1 {
                    // --number is confirmed---
                    if Globals.actual[cPos][rPos] == n {
                        changes = true
                    }
                    // ---accumulate the total score---
                    Globals.totalScore += 2
                }
            }
        }
        return changes
    }
    
    
    /*
    =========================================================
          Look for Lone Rangers in Columns
    =========================================================*/
    static func lookForLoneRangersInColumns() -> Bool {
        var changes = false
        var occurence = 0
        var cPos = 0
        var rPos = 0
        
        // ---check by column----
        for c in 0..<9 {
            for n in 0..<9 {
                occurence = 0
                for r in 0..<9 {
                    if Globals.actual[c][r] == 0  && 
                        Globals.possible[c][r].contains(String(n))  {
                        occurence += 1
                        //---if multiple occurrence, not a lone ranger anymore
                        if occurence > 1 { break }
                        cPos = c
                        rPos = r
                    }
                }
                if occurence == 1 {
                    // --number is confirmed---
                    if Globals.actual[cPos][rPos] == n {
                        changes = true
                    }
                    // ---accumulate the total score---
                    Globals.totalScore += 2
                }
            }
        }
        return changes
    }
    
}
