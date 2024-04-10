//
//  SolvePuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct SolvePuzzle {
    
    
    /*
    ==================================================
     Steps to solve the puzzle
    ==================================================*/
    static func solvePuzzle() -> Bool {
        var changes = false
        var exitLoop = false
        
        repeat {  //---Look for Triplets in Columns---
            repeat {    //---Look for Triplets in Rows---
                repeat {    //---Look for Twins in Minigrids---
                    
                    repeat {    //---Look for Twins in Columns---
                        repeat {   //---Look for Twins in Rows---
                            repeat {    //---Look for Twins in Minigrids---
                                
                                repeat {    //---Look for Lone Rangers in Columns---
                                    repeat {    //---Look for Lone Rangers in Rows---
                                        repeat {    //---Look for Lone Rangers in Minigrids---
                                            
                                            
                                            var count = 0
                                            repeat {   //---Perform Col/Row and Minigrid Elimination---
                                                changes = checkColumnsAndRows()
                                                count += 1
//                                                if MiscFuncs.isPuzzleSolved() {
                                                let x = MiscFuncs.isPuzzleSolved()
                                                
                                                print("1 MG Elim. Changes: \(changes), \(count), \(x)")
                                                
                                                if x {
                                                    print("qqqq")
                                                    exitLoop = true
                                                    break
                                                }
                                                if count > 81 { break }
                                            } while !changes
                                            
                                            
                                            
                                            if exitLoop { break }
                                            //---Look for Lone Rangers in Minigrids---
                                            changes = LoneRangers.lookForLoneRangersInMinigrids()
                                            print("2 LR in Minigrid")
                                            if  MiscFuncs.isPuzzleSolved() {
                                                exitLoop = true
                                                break
                                            }
                                        } while !changes
                                        
                                        if exitLoop { break }
                                        //---Look for Lone Rangers in Rows---
                                        changes = LoneRangers.lookForLoneRangersInRows()
                                        print("3 LR in Rows")
                                        if MiscFuncs.isPuzzleSolved() {
                                            exitLoop = true
                                            break
                                        }
                                    } while !changes
                                    
                                    if exitLoop { break }
                                    //---Look for Lone Rangers in Columns---
                                    changes = LoneRangers.lookForLoneRangersInColumns()
                                    print("4 LR in Columns")
                                    if MiscFuncs.isPuzzleSolved() {
                                        exitLoop = true
                                        break
                                    }
                                } while !changes
                                
                                if exitLoop { break }
                                //---Look For Twins in Minigrids---
                                changes = Twins.lookForTwinsInMinigrids()
                                if MiscFuncs.isPuzzleSolved() {
                                    exitLoop = true
                                    break
                                }
                            } while !changes
                            
                            if exitLoop { break }
                            //---Look For Twins in Rows---
                            changes = Twins.lookForTwinsInRows()
                            if MiscFuncs.isPuzzleSolved() {
                                exitLoop = true
                                break
                            }
                        } while !changes
                        
                        if exitLoop { break }
                        //---Look For Twins in Columns---
                        changes = Twins.lookForTwinsInColumns()
                        if MiscFuncs.isPuzzleSolved() {
                            exitLoop = true
                            break
                        }
                    } while !changes
                    
                    if exitLoop { break }
                    //---Look For Triplets in MiniGrids---
                    changes = Triplets.lookForTripletsInMinigrids()
                    if MiscFuncs.isPuzzleSolved() {
                        exitLoop = true
                        break
                    }
                } while !changes
                
                if exitLoop { break }
                //---Look For Triplets in Rows---
                changes = Triplets.lookForTripletsInRows()
                if MiscFuncs.isPuzzleSolved() {
                    exitLoop = true
                    break
                }
            } while !changes
            
            if exitLoop { break }
            //---Look For Triplets in Columns---
            changes = Triplets.lookForTripletsInColumns()
            if MiscFuncs.isPuzzleSolved() {
                exitLoop = true
                break
            }
        } while !changes
        
        //                    Catch ex As Exception
        //                    Throw New Exception("Invalid Move")
        //                    End Try
        
        if MiscFuncs.isPuzzleSolved() {
            return true
        } else {
            return false
        }
    }
    
    
    
    /*
    =====================================================
        Calculates the possible values for all the cells
    =====================================================*/
    static func checkColumnsAndRows() -> Bool {
        var changes = false
        //---check all cells---
        for row in 0..<9 {
            for col in 0..<9 {
                if Globals.actual[col][row] == 0 {
                    Globals.possible[col][row] = calculatePossibleValues(col: col, row: row)
                }
                print(Globals.possible[col][row], col, row)
                if Globals.possible[col][row].count == 1 {
                    
                    //---number is confirmed---
                    Globals.actual[col][row] = Int(Globals.possible[col][row]) ?? 123
                    changes = true
                    
                    //---accumulate the total score---
                    Globals.totalScore += 1
                }
            }
        }
        return changes
    }
    
    
    /*
    ==================================================
     Calculates the possible values for a cell
    ==================================================*/
    static func calculatePossibleValues(col: Int, row: Int) -> String {
        var str = ""
        
        if Globals.possible[col][row] == "" {
            str = "123456789"
        } else {
            str = Globals.possible[col][row]
        }
        
        //---Step (1) check by column---
        for r in 0..<9 {
            if Globals.actual[col][r] != 0 {
                str = str.replacingOccurrences(of: String(Globals.actual[col][r]), with: "")
            }
        }
        
        //---Step (2) check by row---
        for c in 0..<9 {
            if Globals.actual[c][row] != 0 {
                //---that means there is a actual value in it---
                str = str.replacingOccurrences(of: String(Globals.actual[c][row]), with: "")
            }
        }
        
        //---Step (3) check within the minigrid---
        var startC = 0
        var startR = 0
        startC = col - ((col - 1) % 3)
        startR = row - ((row - 1) % 3)
        for rr in startR..<startR + 2 {
            for cc in startC..<startC + 2 {
                if Globals.actual[cc][rr] != 0 {
                    str = str.replacingOccurrences(of: String(Globals.actual[cc][rr]), with: "")
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
