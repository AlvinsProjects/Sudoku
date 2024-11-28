//
//  Triplets.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct Triplets {
    
    /*
     ==================================================
     Look for Triplets in Minigrids
     ==================================================*/
    static func lookForTripletsInMinigrids() -> Bool {
        var changes = false
        
        //---check each cell---
        for r in 0..<9 {
            for c in 0..<9 {
                
                //--- three possible values; check for triplets---
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count == 3 {
                    
                    //---first potential triplet found---
                    var tripletsLocation = String(c) + String(r)
                    
                    //---scan by mini-grid---
                    let startC = c - (c % 3)
                    let startR = r - (r % 3)
                    for rr in startR...startR + 2 {
                        for cc in startC...startC + 2 {
                            if !((cc == c) && (rr == r)) &&
                                Globals.possible[cc][rr] == Globals.possible[c][r] ||
                                Globals.possible[cc][rr].count == 2 &&
                                Globals.possible[c][r].contains(String(Globals.possible[cc][rr].prefix(1))) &&   //MARK: (0)
                                Globals.possible[c][r].contains(String(Globals.possible[cc][rr].suffix(1))) {    //MARK: (1)
                                
                                //---save the coorindates of the triplets
                                tripletsLocation += (String(cc) + String(rr))
                            }
                        }
                    }
                    
                    //--found 3 cells as triplets; remove all from the other cells---
                    if tripletsLocation.count == 6 {
                        
                        //---remove each cell's possible values containing the triplet---
                        for rrr in startR...startR + 2 {
                            for ccc in startC...startC + 2 {
                                
                                /*---look for the cell that is not part of the
                                     3 cells found--- (using GetNo func)  */
                                if Globals.actual[ccc][rrr] == 0 &&
                                    ccc != getNo(str: tripletsLocation, item: 0) &&
                                    rrr != getNo(str: tripletsLocation, item: 1) &&
                                    ccc != getNo(str: tripletsLocation, item: 2) &&
                                    rrr != getNo(str: tripletsLocation, item: 3) &&
                                    ccc != getNo(str: tripletsLocation, item: 4) &&
                                    rrr != getNo(str: tripletsLocation, item: 5) {
                                    
                                    //---save the original possible values---
                                    let originalPossible = Globals.possible[ccc][rrr]
                                    
                                    //---remove first triplet number from possible values---
                                    //   MARK: (0)
                                    let str = Globals.possible[c][r]
                                    Globals.possible[ccc][rrr] = Globals.possible[ccc][rrr].replacingOccurrences(of: String(getNo(str: str, item: 0)), with: "")
                                    
                                    //---remove second triplet number from possible values---
                                    //   MARK: (1)
                                    Globals.possible[ccc][rrr] = Globals.possible[ccc][rrr].replacingOccurrences(of: String(getNo(str: str, item: 1)), with: "")
                                    
                                    //---remove third triplet number from possible values---
                                    //   MARK: (2)
                                    Globals.possible[ccc][rrr] = Globals.possible[ccc][rrr].replacingOccurrences(of: String(getNo(str: str, item: 2)), with: "")
                                    
                                    /*---if the possible values are modified, then
//                                         set the changes variable to true to indicate
//                                         that the possible values of cells in the
//                                         minigrid have been modified--- */
                                    if originalPossible != Globals.possible[ccc][rrr] {
                                        changes = true
                                    }
                                    
                                    /*---if possible value reduces to empty string,
                                         then the user has placed a move that results
                                         in the puzzle not solvable--- */
                                    if Globals.possible[ccc][rrr] == "" {
                                        print("Invalid Move   Triplets Minigrid")
                                    }
                                    
                                    /*---if left with 1 possible value for the
                                         current cell, cell is confirmed--- */
                                    if Globals.possible[ccc][rrr].count == 1 {
                                        Globals.actual[ccc][rrr] = Int(Globals.possible[ccc][rrr]) ?? 999

                                        Globals.stepsCount += 1
                                        Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Triplet MiniGrid.  Added \(Globals.actual[ccc][rrr]) to (\(ccc), \(rrr))"))
                                        
                                        //---accumulate the total score---
                                        Globals.totalScore += 4
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
    Look for Triplets in Rows
    ==================================================*/
    static func lookForTripletsInRows() -> Bool {
        var changes = false
       
        //---for each row, check each column in the row---
        for r in 0..<9 {
            for c in 0..<9 {
                
                //--- three possible values; check for triplets---
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count == 3 {
                    
                    //--first potential triplet found---
                    var tripletsLocation = (String(c) + String(r))
                    
                    //---scans columns in this row---
                    for cc in 0..<9 {
                        
                        //---look for other triplets---
                        if (cc != c) &&                     //MARK: (0)  (1)
                            ((Globals.possible[cc][r] == Globals.possible[c][r]) ||
                            (Globals.possible[cc][r].count == 2) &&
                            Globals.possible[c][r].contains(String(Globals.possible[cc][r].prefix(1))) &&
                            Globals.possible[c][r].contains(String(Globals.possible[cc][r].suffix(1))))  {
                            
                            //---save the coorindates of the triplet---
                            tripletsLocation += (String(cc) + String(r))
//                            print(tripletsLocation)
                        }
                    }
                    
                    //--found 3 cells as triplets; remove all from the other
                    //  cells---
                    if tripletsLocation.count == 6 {
                        
                        //---remove each cell's possible values containing the
                        //   triplet---
                        for ccc in 0..<9 {
                            if Globals.actual[ccc][r] == 0 &&
                                ccc != getNo(str: tripletsLocation, item: 0) &&
                                ccc != getNo(str: tripletsLocation, item: 2) &&
                                ccc != getNo(str: tripletsLocation, item: 4 ) {
                                 
                                //---save the original possible values ---
                                let originalPossible = Globals.possible[ccc][r]
                                
                                //---remove first triplet number from possible values---
                                //   MARK:  (0)
                                let strg = Globals.possible[c][r]
                                Globals.possible[ccc][r] = Globals.possible[ccc][r].replacingOccurrences(of: String(getNo(str: strg, item: 0)), with: "")
                                
                                //---remove second triplet number from possible values---
                                //   MARK:  (1)
                                Globals.possible[ccc][r] = Globals.possible[ccc][r].replacingOccurrences(of: String(getNo(str: strg, item: 1)), with: "")
                                
                                //---remove third triplet number from possible values---
                                //   MARK:  (2)
                                Globals.possible[ccc][r] = Globals.possible[ccc][r].replacingOccurrences(of: String(getNo(str: strg, item: 2)), with: "")
                                
                                //---if the possible values are modified, then
                                //   set the changes variable to true to indicate
                                //   that the possible values of cells in the
                                //   minigrid have been modified---
                                if originalPossible != Globals.possible[ccc][r] {
                                    changes = true
                                }
                                
                                //---if possible value reduces to empty string,
                                //   then the user has placed a move that results
                                //   in the puzzle not solvable---
                                if Globals.possible[ccc][r] == "" {
                                    print("Invalid move.  Triplets Row")
                                }
                                
                                //---if left with 1 possible value for the
                                //   current cell, cell is confirmed---
                                if Globals.possible[ccc][r].count == 1 {
                                    Globals.actual[ccc][r] = Int(Globals.possible[ccc][r]) ?? 999

                                    Globals.stepsCount += 1
                                    Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Triplet Rows.  Added \(Globals.actual[ccc][r]) to (\(ccc), \(r))"))
                                                                                
                                                                                
                                    //---accumulate the total score---
                                    Globals.totalScore += 4
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
    Look for Triplets in Columns
    ==================================================*/
    static func lookForTripletsInColumns() -> Bool {
        var changes = false
       
        //---for each row, check each row in the column---
        for c in 0..<9 {
            for r in 0..<9 {
                
                //--- three possible values; check for triplets---
                if Globals.actual[c][r] == 0 && Globals.possible[c][r].count == 3 {
                    
                    //--first potential triplet found---
                    var tripletsLocation = String(c) + String(r)
                    
                    //---scans columns in this row---
                    for rr in 0..<9 {
                        if rr != r &&
                            Globals.possible[c][rr] == Globals.possible[c][r] ||
                            Globals.possible[c][rr].count == 2 &&  //MARK:  (0) and (1) below
                            Globals.possible[c][r].contains(Globals.possible[c][rr].prefix(1)) &&
                            Globals.possible[c][r].contains(Globals.possible[c][rr].suffix(1)) {
                            
                            //---save the original possible values ---
                            tripletsLocation += (String(c) + String(rr))
                        }
                    }
                    
                    //--found 3 cells as triplets; remove all from the other cells---
                    if tripletsLocation.count == 6 {
                        
                        //---remove each cell's possible values containing the
                        //   triplet---
                        for rrr in 0..<9 {
                            if Globals.actual[c][rrr] == 0 &&
                                rrr != getNo(str: tripletsLocation, item: 1) &&
                                rrr != getNo(str: tripletsLocation, item: 3) &&
                                rrr != getNo(str: tripletsLocation, item: 5 ) {
                                
                                //---save the original possible values---
                                let originalPossible = Globals.possible[c][rrr]
                                
                                let str = Globals.possible[c][r]    //simplify the code
                                //---remove first triplet number from possible values---
                                //   MARK: (0)
                                Globals.possible[c][rrr] = Globals.possible[c][rrr].replacingOccurrences(of: String(getNo(str: str, item: 0)), with: "")
                                
                                //---remove second triplet number from possible values---
                                //   MARK: (1)
                                Globals.possible[c][rrr] = Globals.possible[c][rrr].replacingOccurrences(of: String(getNo(str: str, item: 1)), with: "")
                                
                                //---remove third triplet number from possible values---
                                //   MARK: (2)
                                Globals.possible[c][rrr] = Globals.possible[c][rrr].replacingOccurrences(of: String(getNo(str: str, item: 2)), with: "")
                                
                                
                                //---if the possible values are modified, then
                                //   set the changes variable to true to indicate
                                //   that the possible values of cells in the
                                //   minigrid have been modified---
                                if originalPossible != Globals.possible[c][rrr] {
                                    changes = true
                                }
                                
                                //---if possible value reduces to empty string,
                                //   then the user has placed a move that results
                                //   in the puzzle not solvable---
                                if Globals.possible[c][rrr] == "" {
                                    print("Invalid move   Triplets Column")
                                }
                                
                                //---if left with 1 possible value for the
                                //   current cell, cell is confirmed---
                                if Globals.possible[c][rrr].count == 1 {
                                    Globals.actual[c][rrr] = Int(Globals.possible[c][rrr]) ?? 999

                                    Globals.stepsCount += 1
                                    Globals.stepsTakenArray.append(StepsTaken(index: Globals.stepsCount, steps: "Triplet Columns.                Added \(Globals.actual[c][rrr]) to (\(c), \(rrr))"))
                                    
                                    //---accumulate the total score---
                                    Globals.totalScore += 4
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
    ==============================================================
      Get the Integer by index number, from a string (of numbers)
    ==============================================================*/
    static func getNo(str: String, item: Int) -> Int {
        Int(String(str[str.index(str.startIndex, offsetBy: item)])) ?? 999
    }
    
}
