//
//  SolvePuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct SolvePuzzle {
    
    
    // ==================================================
    //  Steps to solve the puzzle
    // ==================================================
    func solvePuzzle() -> Bool {
        var changes = false
        var exitLoop = false
        
        //Try
        //Do '---Look for Triplets in Columns---
        
        repeat {  //---Look for Triplets in Rows---
            repeat {    //---Look for Triplets in Minigrids---
                repeat {    //---Look for Twins in Columns---
                    repeat {    //---Look for Twins in Rows---
                        repeat {   //---Look for Twins in Minigrids---
                            repeat {    //---Look for Lone Rangers in Columns---
                                repeat {    //---Look for Lone Rangers in Rows---
                                    repeat {    //---Look for Lone Rangers in
                                        repeat {    //---Look for Lone Rangers in Minigrids---
                                            repeat {   //---Perform Col/Row and Minigrid Elimination---
                                                changes = checkColumnsAndRows()
                                                if MiscFuncs().isPuzzleSolved() {
                                                    exitLoop = true
                                                    break
                                                }
                                            } while !changes
                                            
                                            if exitLoop { break }
                                            //    '---Look for Lone Rangers in Minigrids---
                                            changes = LoneRangers().lookForLoneRangersInMinigrids()
                                            if  MiscFuncs().isPuzzleSolved() {
                                                exitLoop = true
                                                break
                                            }
                                        } while !changes
                                        
                                        if exitLoop { break }
                                        //    '---Look for Lone Rangers in Rows---
                                        changes = LoneRangers().lookForLoneRangersInRows()
                                        if MiscFuncs().isPuzzleSolved() {
                                            exitLoop = true
                                            break
                                        }
                                    } while !changes
                                    
                                    if exitLoop { break }
                                    //    '---Look for Lone Rangers in Columns---
                                    changes = LoneRangers().lookForLoneRangersInColumns()
                                    if MiscFuncs().isPuzzleSolved() {
                                        exitLoop = true
                                        break
                                    }
                                } while !changes
                                
                                if exitLoop { break }
                                //    '---Look For Twins in Minigrids---
                                changes = Twins().lookForTwinsInMinigrids()
                                if MiscFuncs().isPuzzleSolved() {
                                    exitLoop = true
                                    break
                                }
                            } while !changes
                            
                            if exitLoop { break }
                            //    '---Look For Twins in Rows---
                            changes = Twins().lookForTwinsInRows()
                            if MiscFuncs().isPuzzleSolved() {
                                exitLoop = true
                                break
                            }
                        } while !changes
                        
                        if exitLoop { break }
                        //    '---Look For Twins in Columns---
                        changes = Twins().lookForTwinsInColumns()
                        if MiscFuncs().isPuzzleSolved() {
                            exitLoop = true
                            break
                        }
                    } while !changes
                    
                    if exitLoop { break }
                    //    '---Look For Triplets in MiniGrids---
                    changes = Triplets().lookForTripletsInMinigrids()
                    if MiscFuncs().isPuzzleSolved() {
                        exitLoop = true
                        break
                    }
                } while !changes
                
                if exitLoop { break }
                //    '---Look For Triplets in Rows---
                changes = Triplets().lookForTripletsInRows()
                if MiscFuncs().isPuzzleSolved() {
                    exitLoop = true
                    break
                }
            } while !changes
            
            if exitLoop { break }
            //    '---Look For Triplets in Columns---
            changes = Triplets().lookForTripletsInColumns()
            if MiscFuncs().isPuzzleSolved() {
                exitLoop = true
                break
            }
        } while !changes
        
        //                    Catch ex As Exception
        //                    Throw New Exception("Invalid Move")
        //                    End Try
        
        if MiscFuncs().isPuzzleSolved() {
            return true
        } else {
            return false
        }
    }
    
    
    
    //==================================================
    //  Calculates the possible values for all the cells
    //==================================================
    func checkColumnsAndRows() -> Bool {
        var changes = false
        for row in 0..<9 {
            for col in 0..<9 {
                if Vars.actual[col][row] == 0 {
                    Vars.possible[col][row] = (calculatePossibleValues(col: col, row: row))
                }
                
                if Vars.possible[col][row].count == 1 {
                    
                    //---number is confirmed---
                    Vars.actual[col][row] = Int(Vars.possible[col][row]) ?? 123
                    changes = true
                    
                    //---accumulate the total score---
                    Vars.totalScore += 1
                }
            }
        }
        return changes
    }
    
    
    
    //==================================================
    // Calculates the possible values for a cell
    //==================================================
    func calculatePossibleValues(col: Int, row: Int) -> String {
        var str = ""
        
        if Vars.possible[col][row] == "" {
            str = "123456789"
        } else {
            str = Vars.possible[col][row]
        }
        
        //    var r = 0
        //    var c = 0
        
        for r in 0..<9 {
            if Vars.actual[col][r] != 0 {
                str = str.replacingOccurrences(of: String(Vars.actual[col][r]), with: "")
            }
        }
        
        //---Step (2) check by row---
        for c in 0..<9 {
            if Vars.actual[c][row] != 0 {
                //---that means there is a actual value in it---
                str = str.replacingOccurrences(of: String(Vars.actual[c][row]), with: "")
            }
        }
        
        //---Step (3) check within the minigrid---
        var startC = 0
        var startR = 0
        startC = col - ((col - 1) % 3)
        startR = row - ((row - 1) % 3)
        for rr in startR..<startR + 2 {
            for cc in startC..<startC + 2 {
                if Vars.actual[cc][rr] != 0 {
                    str = str.replacingOccurrences(of: String(Vars.actual[cc][rr]), with: "")
                }
            }
        }
        //---if possible value is string.Empty, then error---
        if str == "" {
            print("Invalid Move")
        }
        return str
    }
    
}
