//
//  Twins.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct Twins {
    
    
    // ==================================================
    //       Look for Twins in Minigrids
    // ==================================================
    func lookForTwinsInMinigrids() -> Bool {
        var changes = false
        
        // ---look for twins in each cell---
        for r in 0..<9 {
            for c in 0..<9 {
                
                // ---if two possible values, check for twins---
                if Vars.actual[c][r] == 0 && Vars.possible[c][r].count == 2 {
                    
                    //---scan by the mini-grid that the current cell is
                    var startC = 0
                    var startR = 0
                    startC = c - ((c - 1) % 3)
                    startR = r - ((r - 1) % 3)
                    for rr in startR...startR + 2 {
                        for cc in startC...startC + 2 {
                            
                            //---for cells other than the pair of twins---
                            if !(cc == c && rr == r) && Vars.possible[cc][rr] == Vars.possible[c][r] {
                                // ---remove the twins from all the other possible
                                for rrr in startR...startR + 2 {
                                    for ccc in startC...startC + 2 {
                                        if Vars.actual[ccc][rrr] == 0 && Vars.possible[ccc][rrr] != Vars.possible[c][r] {
                                            
                                            //---save a copy of the original
                                            // possible values (twins)---
                                            var original_possible = Vars.possible[c][r]
                                            
                                            //MARK: Following has (0) in last term
                                            //---remove first twin number from
                                            // possible values---
                                            Vars.possible[ccc][rrr] = Vars.possible[ccc][rrr].replacingOccurrences(of: Vars.possible[c][r], with: "")
                                            
                                            //MARK: Following has (1) in last term
                                            //---remove second twin number from
                                            // possible values---
                                            Vars.possible[ccc][rrr] = Vars.possible[ccc][rrr].replacingOccurrences(of: Vars.possible[c][r], with: "")
                                            
                                            //---if the possible values are
                                            // modified, then set the changes
                                            // variable to true to indicate
                                            // that the possible values of cells
                                            // in the minigrid have been modified---
                                            if original_possible != Vars.possible[ccc][rrr] {
                                                changes = true
                                            }
                                            
                                            //---if possible value reduces to
                                            // empty string, then the user has
                                            // placed a move that results in
                                            // the puzzle not solvable---
                                            if Vars.possible[ccc][rrr] == "" {
                                                print("Invalid Move")
                                            }
                                            
                                            //---if left with 1 possible value
                                            // for the current cell, cell is
                                            // confirmed---
                                            if Vars.possible[ccc][rrr].count == 1 {
                                                Vars.actual[ccc][rrr] = Int(Vars.possible[ccc][rrr]) ?? 999
                                                Vars.totalScore += 3
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
                if Vars.actual[c][r] == 0 && Vars.possible[c][r].count == 2 {
                    
                    //--scan columns in this row---
                    for cc in (c + 1)..<9 {
                        if Vars.possible[cc][r] == Vars.possible[c][r] {
                            
                            //---remove the twins from all the other possible
                            //   values in the row---
                            for ccc in 0..<9 {
                                if Vars.actual[ccc][r] == 0 && (ccc != c) && (ccc != cc) {
                                    
                                    //---save a copy of the original possible
                                    // values (twins)---
                                    var original_possible = Vars.possible[ccc][r]
                                    
                                    //---remove first twin number from possible
                                    // values--- MARK: ########### (0)
                                    Vars.possible[ccc][r] = Vars.possible[ccc][r].replacingOccurrences(of: Vars.possible[c][r], with: "")
                                    
                                    //---remove second twin number from possible
                                    // values--- MARK: ########### (1)
                                    Vars.possible[ccc][r] = Vars.possible[ccc][r].replacingOccurrences(of: Vars.possible[c][r], with: "")
                                    
                                    //--if the possible values are modified, then
                                    // set the changes variable to true to indicate
                                    // that the possible values of cells in the
                                    // minigrid have been modified---
                                    if original_possible != Vars.possible[ccc][r] {
                                        changes = true
                                    }
                                    
                                    //---if possible value reduces to empty string,
                                    // then the user has placed a move that results
                                    // in the puzzle not solvable---
                                    if original_possible != Vars.possible[ccc][r] {
                                        print("Invalid Move")
                                    }
                                    
                                    //---if left with 1 possible value for the
                                    // current cell, cell is confirmed---
                                    if  Vars.possible[ccc][r].count == 1 {
                                        Vars.actual[ccc][r] = Int(Vars.possible[ccc][r]) ?? 999
                                        
                                        //---accumulate the total score---
                                        Vars.totalScore += 3
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
                if Vars.actual[c][r] == 0 && Vars.possible[c][r].count == 2 {
                    
                    //--scan rows in this column---
                    for rr in 0..<9 {
                        if Vars.possible[c][rr] == Vars.possible[c][r] {
                            
                            //---remove the twins from all the other possible
                            //values in the row---
                            for rrr in 0..<9 {
                                if Vars.actual[c][rr] == 0 && (rrr != r) && (rrr != rr) {
                                    
                                    //---save a copy of the original possible
                                    // values (twins)---
                                    var original_possible = Vars.possible[c][rrr]
                                    
                                    //---remove first twin number from possible
                                    // values---  MARK: ########### (0)
                                    Vars.possible[c][rrr] = Vars.possible[c][rrr].replacingOccurrences(of: Vars.possible[c][r], with: "")
                                    
                                    //---remove second twin number from possible
                                    // values---  MARK: ########### (1)
                                    Vars.possible[c][rrr] = Vars.possible[c][rrr].replacingOccurrences(of: Vars.possible[c][r], with: "")
                                    
                                    //---if the possible values are modified, then
                                    // set the changes variable to true to indicate
                                    // that the possible values of cells in the
                                    //minigrid have been modified---
                                    if original_possible != Vars.possible[c][rrr] {
                                        changes = true
                                    }
                                    
                                    //---if possible value reduces to empty string,
                                    // then the user has placed a move that results
                                    // in the puzzle not solvable---
                                    if Vars.possible[c][rrr] == "" {
                                        print("Invalid Move")
                                    }
                                    
                                    //--if left with 1 possible value for the
                                    // current cell, cell is confirmed---
                                    if  Vars.possible[c][rrr].count == 1 {
                                        Vars.actual[c][rrr] = Int(Vars.possible[c][rrr]) ?? 999
                                        
                                        //---accumulate the total score---
                                        Vars.totalScore += 3
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
