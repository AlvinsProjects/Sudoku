//
//  Twins.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


// ==================================================
//       Look for Twins in Minigrids
// ==================================================
func lookForTwinsInMinigrids() -> Bool {
    var changes = false

    // ---look for twins in each cell---
    for r in 0..<9 {
        for c in 0..<9 {
            
            // ---if two possible values, check for twins---
            if Variables.actual[c][r] == 0 && Variables.possible[c][r].count == 2 {
                
                //---scan by the mini-grid that the current cell is
                var startC = 0
                var startR = 0
                startC = c - ((c - 1) % 3)
                startR = r - ((r - 1) % 3)
                for rr in startR...startR + 2 {
                    for cc in startC...startC + 2 {
                        
                        //---for cells other than the pair of twins---
                        if !(cc == c && rr == r) && Variables.possible[cc][rr] == Variables.possible[c][r] {
                            // ---remove the twins from all the other possible
                            for rrr in startR...startR + 2 {
                                for ccc in startC...startC + 2 {
                                    if Variables.actual[ccc][rrr] == 0 && Variables.possible[ccc][rrr] != Variables.possible[c][r] {
                                        
                                        //---save a copy of the original
                                        // possible values (twins)---
                                        var original_possible = Variables.possible[c][r]
                                        
                                        //MARK: Following has (0) in last term
                                        //---remove first twin number from
                                        // possible values---
                                        Variables.possible[ccc][rrr] = Variables.possible[ccc][rrr].replacingOccurrences(of: Variables.possible[c][r], with: "")
                                        
                                        //MARK: Following has (1) in last term
                                        //---remove second twin number from
                                        // possible values---
                                        Variables.possible[ccc][rrr] = Variables.possible[ccc][rrr].replacingOccurrences(of: Variables.possible[c][r], with: "")
                                        
                                        //---if the possible values are
                                        // modified, then set the changes
                                        // variable to true to indicate
                                        // that the possible values of cells
                                        // in the minigrid have been modified---
                                        if original_possible != Variables.possible[ccc][rrr] {
                                            changes = true
                                        }
                                        
                                        //---if possible value reduces to
                                        // empty string, then the user has
                                        // placed a move that results in
                                        // the puzzle not solvable---
                                        if Variables.possible[ccc][rrr] == "" {
                                            print("Invalid Move")
                                        }
                                        
                                        //---if left with 1 possible value
                                        // for the current cell, cell is
                                        // confirmed---
                                        if Variables.possible[ccc][rrr].count == 1 {
                                            Variables.actual[ccc][rrr] = Int(Variables.possible[ccc][rrr]) ?? 999
                                            Variables.totalScore += 3
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



// ==================================================
//       Look for Twins in Rows
// ==================================================

func lookForTwinsInRows() -> Bool {
    var changes = false
    
    // ---for each row, check each column in the row---
    for r in 0..<9 {
        for c in 0..<9 {
            
            // ---if two possible values, check for twins---
            if Variables.actual[c][r] == 0 && Variables.possible[c][r].count == 2 {
                
                //--scan columns in this row---
                for cc in (c + 1)..<9 {
                    if Variables.possible[cc][r] == Variables.possible[c][r] {
                        
                        //---remove the twins from all the other possible
                        //   values in the row---
                        for ccc in 0..<9 {
                            if Variables.actual[ccc][r] == 0 && (ccc != c) && (ccc != cc) {
                                
                                //---save a copy of the original possible
                                // values (twins)---
                                var original_possible = Variables.possible[ccc][r]
                                
                                //---remove first twin number from possible
                                // values--- MARK: ########### (0)
                                Variables.possible[ccc][r] = Variables.possible[ccc][r].replacingOccurrences(of: Variables.possible[c][r], with: "")
                                
                                //---remove second twin number from possible
                                // values--- MARK: ########### (1)
                                Variables.possible[ccc][r] = Variables.possible[ccc][r].replacingOccurrences(of: Variables.possible[c][r], with: "")
                                
                                //--if the possible values are modified, then
                                // set the changes variable to true to indicate
                                // that the possible values of cells in the
                                // minigrid have been modified---
                                if original_possible != Variables.possible[ccc][r] {
                                    changes = true
                                }
                                
                                //---if possible value reduces to empty string,
                                // then the user has placed a move that results
                                // in the puzzle not solvable---
                                if original_possible != Variables.possible[ccc][r] {
                                    print("Invalid Move")
                                }
                                
                                //---if left with 1 possible value for the
                                // current cell, cell is confirmed---
                                if  Variables.possible[ccc][r].count == 1 {
                                    Variables.actual[ccc][r] = Int(Variables.possible[ccc][r]) ?? 999
                                    
                                    //---accumulate the total score---
                                    Variables.totalScore += 3
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



// ==================================================
//       Look for Twins in Columns
// ==================================================
func lookForTwinsInColumns() -> Bool {
    var changes = false
    
    // ---for each row, check each column in the row---
    for r in 0..<9 {
        for c in 0..<9 {
            
            //---if two possible values, check for twins---
            if Variables.actual[c][r] == 0 && Variables.possible[c][r].count == 2 {
                
                //--scan rows in this column---
                for rr in 0..<9 {
                    if Variables.possible[c][rr] == Variables.possible[c][r] {
                        
                        //---remove the twins from all the other possible
                        //values in the row---
                        for rrr in 0..<9 {
                            if Variables.actual[c][rr] == 0 && (rrr != r) && (rrr != rr) {
                                
                                //---save a copy of the original possible
                                // values (twins)---
                                var original_possible = Variables.possible[c][rrr]
                                
                                //---remove first twin number from possible
                                // values---  MARK: ########### (0)
                                Variables.possible[c][rrr] = Variables.possible[c][rrr].replacingOccurrences(of: Variables.possible[c][r], with: "")
                                
                                //---remove second twin number from possible
                                // values---  MARK: ########### (1)
                                Variables.possible[c][rrr] = Variables.possible[c][rrr].replacingOccurrences(of: Variables.possible[c][r], with: "")
                                
                                //---if the possible values are modified, then
                                // set the changes variable to true to indicate
                                // that the possible values of cells in the
                                //minigrid have been modified---
                                if original_possible != Variables.possible[c][rrr] {
                                    changes = true
                                }
                                
                                //---if possible value reduces to empty string,
                                // then the user has placed a move that results
                                // in the puzzle not solvable---
                                if Variables.possible[c][rrr] == "" {
                                    print("Invalid Move")
                                }
                                
                                //--if left with 1 possible value for the
                                // current cell, cell is confirmed---
                                if  Variables.possible[c][rrr].count == 1 {
                                    Variables.actual[c][rrr] = Int(Variables.possible[c][rrr]) ?? 999
                                    
                                    //---accumulate the total score---
                                    Variables.totalScore += 3
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
