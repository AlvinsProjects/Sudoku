//
//  SolvePuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


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
                                            if isPuzzleSolved() {
                                                exitLoop = true
                                                break
                                            }
                                        } while !changes
                                        
                                        if exitLoop { break }
                                        //    '---Look for Lone Rangers in Minigrids---
                                        changes = lookForLoneRangersInMinigrids()
                                        if isPuzzleSolved() {
                                            exitLoop = true
                                            break
                                        }
                                    } while !changes
                                    
                                    if exitLoop { break }
                                    //    '---Look for Lone Rangers in Rows---
                                    changes = lookForLoneRangersInRows()
                                    if isPuzzleSolved() {
                                        exitLoop = true
                                        break
                                    }
                                } while !changes
                                
                                if exitLoop { break }
                                //    '---Look for Lone Rangers in Columns---
                                changes = lookForLoneRangersInColumns()
                                if isPuzzleSolved() {
                                    exitLoop = true
                                    break
                                }
                            } while !changes
                            
                            if exitLoop { break }
                            //    '---Look For Twins in Minigrids---
                            changes = lookForTwinsInMinigrids()
                            if isPuzzleSolved() {
                                exitLoop = true
                                break
                            }
                        } while !changes
                        
                        if exitLoop { break }
                        //    '---Look For Twins in Rows---
                        changes = lookForTwinsInRows()
                        if isPuzzleSolved() {
                            exitLoop = true
                            break
                        }
                    } while !changes
                    
                    if exitLoop { break }
                    //    '---Look For Twins in Columns---
                    changes = lookForTwinsInColumns()
                    if isPuzzleSolved() {
                        exitLoop = true
                        break
                    }
                } while !changes
                
                if exitLoop { break }
                //    '---Look For Triplets in MiniGrids---
                changes = lookForTripletsInMinigrids()
                if isPuzzleSolved() {
                    exitLoop = true
                    break
                }
            } while !changes
            
            if exitLoop { break }
            //    '---Look For Triplets in Rows---
            changes = lookForTripletsInRows()
            if isPuzzleSolved() {
                exitLoop = true
                break
            }
        } while !changes
        
        if exitLoop { break }
        //    '---Look For Triplets in Columns---
        changes = lookForTripletsInColumns()
        if isPuzzleSolved() {
            exitLoop = true
            break
        }
    } while !changes
    
    //                    Catch ex As Exception
    //                    Throw New Exception("Invalid Move")
    //                    End Try
    
    if isPuzzleSolved() {
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
            if Variables.actual[col][row] == 0 {
                Variables.possible[col][row] = (calculatePossibleValues(col: col, row: row))
            }
            
            if Variables.possible[col][row].count == 1 {
               
                //---number is confirmed---
                Variables.actual[col][row] = Int(Variables.possible[col][row]) ?? 123
                changes = true
                
                //---accumulate the total score---
                Variables.totalScore += 1
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

    if Variables.possible[col][row] == "" {
        str = "123456789"
    } else {
        str = Variables.possible[col][row]
    }

    var r = 0
    var c = 0
    
    for r in 0..<9 {
        if Variables.actual[col][r] != 0 {
            str = str.replacingOccurrences(of: String(Variables.actual[col][r]), with: "")
        }
    }
    
    //---Step (2) check by row---
    for c in 0..<9 {
        if Variables.actual[c][row] != 0 {
            //---that means there is a actual value in it---
            str = str.replacingOccurrences(of: String(Variables.actual[c][row]), with: "")
        }
    }
    
    //---Step (3) check within the minigrid---
    var startC = 0
    var startR = 0
    startC = col - ((col - 1) % 3)
    startR = row - ((row - 1) % 3)
    for rr in startR..<startR + 2 {
        for cc in startC..<startC + 2 {
            if Variables.actual[cc][rr] != 0 {
                str = str.replacingOccurrences(of: String(Variables.actual[cc][rr]), with: "")
            }
        }
    }
    //---if possible value is string.Empty, then error---
    if str == "" {
        print("Invalid Move")
    }
    return str
}