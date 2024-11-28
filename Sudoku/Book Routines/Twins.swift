//
//  Twins.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct Twins {
    
    /* 
    ==================================================
    Look for Twins in Minigrids
    ==================================================*/
    static func lookForTwinsInMinigrids() -> Bool {
        var changes = false
        
        //---look for twins in each cell---
        for r in 0..<9 {
            for c in 0..<9 {
                
                //---if two possible values, check for twins---
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count == 2 {
                    
                    //---scan by the mini-grid that the current cell is
                    let startC = c - (c % 3)
                    let startR = r - (r % 3)
                    for rr in startR...(startR + 2) {
                        for cc in startC...(startC + 2) {
                            
                            //---for cells other than the pair of twins---
                            if !(cc == c && rr == r) && Globals.possible[cc][rr] == Globals.possible[c][r] {
                                
                                //---remove the twins from all the other possible values in
                                //   the minigrid---
                                for rrr in startR...startR + 2 {
                                    for ccc in startC...startC + 2 {
                                        
                                        if Globals.actual[ccc][rrr] == 0 && Globals.possible[ccc][rrr] != Globals.possible[c][r] {
                                            
                                            //---save a copy of the original
                                            //   possible values (twins)---
                                            let original_possible = Globals.possible[ccc][rrr]
                                            
                                            //MARK: Following has (0) in last term - used Prefix
                                            //---remove first twin number from
                                            //   possible values---
                                            Globals.possible[ccc][rrr] = Globals.possible[ccc][rrr].replacingOccurrences(of: Globals.possible[c][r].prefix(1), with: "")
                                            
                                            //MARK: Following has (1) in last term - used Suffix
                                            //---remove second twin number from
                                            //   possible values---
                                            Globals.possible[ccc][rrr] = Globals.possible[ccc][rrr].replacingOccurrences(of: Globals.possible[c][r].suffix(1), with: "")

                                            /*---if the possible values are
                                                 modified, then set the changes
                                                 variable to true to indicate
                                                 that the possible values of cells
                                                 in the minigrid have been modified--- */
                                            if original_possible != Globals.possible[ccc][rrr] {
                                                changes = true
                                            }
                                            
                                            /*---if possible value reduces to
                                                 empty string, then the user has
                                                 placed a move that results in
                                                 the puzzle not solvable--- */
                                            if Globals.possible[ccc][rrr] == "" {
                                                print("Invalid Move = Twins Minigrid")
                                            }
                                            
                                            /*---if left with 1 possible value
                                                 for the current cell, cell is
                                                 confirmed--- */
                                            if Globals.possible[ccc][rrr].count == 1 {
                                                Globals.actual[ccc][rrr] = Int(Globals.possible[ccc][rrr]) ?? 999
                                                
                                                Globals.stepsCount += 1
                                                Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Twins MiniGrid.            Added \(Globals.actual[ccc][rrr]) to (\(ccc), \(rrr))"))
                                                
                                                Globals.totalScore += 3
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return changes
    }
    
    
    
    /*
     ==================================================
     Look for Twins in Rows
     ==================================================*/
    static func lookForTwinsInRows() -> Bool {
        var changes = false
        
        // ---for each row, check each column in the row---
        for r in 0..<9 {
            for c in 0..<9 {
                
                // ---if two possible values, check for twins---
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count == 2 {
                    
                    // --scan columns in this row---
                    for cc in (c + 1)..<9 {
                        if Globals.possible[cc][r] == Globals.possible[c][r] {
                            
                            // ---remove the twins from all the other possible
                            //    values in the row---
                            for ccc in 0..<9 {
                                if Globals.actual[ccc][r] == 0 && (ccc != c) && (ccc != cc) {
                                    
                                    // ---save a copy of the original possible
                                    //    values (twins)---
                                    let original_possible = Globals.possible[ccc][r]
                                    
                                    // ---remove first twin number from possible
                                    //    values--- MARK: ########### (0)
                                    Globals.possible[ccc][r] = Globals.possible[ccc][r].replacingOccurrences(of: Globals.possible[c][r].prefix(0), with: "")
                                    
                                    //---remove second twin number from possible
                                    //   values--- MARK: ########### (1)
                                    Globals.possible[ccc][r] = Globals.possible[ccc][r].replacingOccurrences(of: Globals.possible[c][r].suffix(1), with: "")

                                    
                                    //---if the possible values are modified, then
                                    //   set the changes variable to true to indicate
                                    //   that the possible values of cells in the
                                    //   minigrid have been modified---
                                    if original_possible != Globals.possible[ccc][r] {
                                        changes = true
                                    }
                                    
                                    //---if possible value reduces to empty string,
                                    //   then the user has placed a move that results
                                    //   in the puzzle not solvable---
                                    if Globals.possible[ccc][r].isEmpty {
                                        print("Invalid Move - Twins Rows")
                                    }
                                    
                                    //---if left with 1 possible value for the
                                    //   current cell, cell is confirmed---
                                    if  Globals.possible[ccc][r].count == 1 {
                                        Globals.actual[ccc][r] = Int(Globals.possible[ccc][r]) ?? 999
                                        
                                        Globals.stepsCount += 1
                                        Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Twins Row.                     Added \(Globals.actual[ccc][r]) to (\(ccc), \(r))"))
                                        
                                        //---accumulate the total score---
                                        Globals.totalScore += 3
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return changes
    }
    
    
    
    /*
    ==================================================
     Look for Twins in Columns
    ==================================================*/
    static func lookForTwinsInColumns() -> Bool {
        var changes = false
        
        // ---for each row, check each column in the row---
        for r in 0..<9 {
            for c in 0..<9 {
                
                //---if two possible values, check for twins---
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count == 2 {
                    
                    //---scan rows in this column---
                    for rr in (r + 1)..<9 {
                        if Globals.possible[c][rr] == Globals.possible[c][r] {
                            
                            //---remove the twins from all the other possible
                            //   values in the row---
                            for rrr in 0..<9 {
                                if Globals.actual[c][rrr] == 0 && (rrr != r) && (rrr != rr) {
                                    
                                    //---save a copy of the original possible values (twins)---
                                    let original_possible = Globals.possible[c][rrr]
                                    
                                    //---remove first twin number from possible values---
                                    //    MARK: ########### (0)
                                    Globals.possible[c][rrr] = Globals.possible[c][rrr].replacingOccurrences(of: Globals.possible[c][r].prefix(0), with: "")
                                   
                                    //---remove second twin number from possible values---
                                    //    MARK: ########### (1)
                                    Globals.possible[c][rrr] = Globals.possible[c][rrr].replacingOccurrences(of: Globals.possible[c][r].suffix(1), with: "")
                                    
                                    //---if the possible values are modified, then
                                    //   set the changes variable to true to indicate
                                    //   that the possible values of cells in the
                                    //   minigrid have been modified---
                                    if original_possible != Globals.possible[c][rrr] {
                                        changes = true
                                    }
                                    
                                    //---if possible value reduces to empty string,
                                    //   then the user has placed a move that results
                                    //   in the puzzle not solvable---
                                    if Globals.possible[c][rrr] == "" {
                                        print("Invalid Move - Twin Columns")
                                    }
                                    
                                    //---if left with 1 possible value for the
                                    //   current cell, cell is confirmed---
                                    if  Globals.possible[c][rrr].count == 1 {
                                        Globals.actual[c][rrr] = Int(Globals.possible[c][rrr]) ?? 999
                                        
                                        Globals.stepsCount += 1
                                        Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Twins Column.                Added \(Globals.actual[c][rrr]) to (\(c), \(rrr))"))
                                                                                    
                                        //---accumulate the total score---
                                        Globals.totalScore += 3
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return changes
    }
}

