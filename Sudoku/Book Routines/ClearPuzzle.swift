//
//  ClearPuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//

import Foundation


struct ClearPuzzle {
    
    
    /*
     ============================================================
     Clear the previous Sudoku puzzle
     ============================================================*/
    func clearPreviousPuzzle() {
        
        for j in 0..<9 {
            for k in 0..<9 {
                Globals.actual[j][k] = 0
                Globals.possible[j][k] = ""
                Globals.GlobePlayers[j][k] = ""
                Globals.inputPuzzle[j][k] = 0
            }
        }
        
        
        //---clear the stacks and backups---
        Globals.actualStack.removeAll()
        Globals.possibleStack.removeAll()
        Globals.stepsTakenArray.removeAll()
        Globals.stepsTakenArray.removeAll()
        
        Globals.bruteForceStop = false
        Globals.stepsTakenArray.removeAll()
        Globals.stepsCount = 0
        
    }
}
        





        

        //        //---populate the board with numbers by solving an empty grid---
        //        if !SolvePuzzle.solvePuzzle() {
        //            // ---then use bruteforce---
        //            BruteForce.solvePuzzleByBruteForce()
        //        } else {
        //            print("Error!")
        //        }
        //        
        //        //---make a backup copy of the Actual array---
        //        Globals.actualBackup = Globals.actual
        //        
        //        //---set the number of empty cells based on the level of difficulty---
        //        switch level {
        //            case 1: numberOfEmptyCells = Int.random(in: 40...45)
        //            case 2: numberOfEmptyCells = Int.random(in: 46...49)
        //            case 3: numberOfEmptyCells = Int.random(in: 50...53)
        //            case 4: numberOfEmptyCells = Int.random(in: 54...58)
        //            default:
        //                print("Error at line 87 of generateNewPuzzle")
        //                break
        //        }
        
        
        //---clear the stacks that are used in brute-force elimination ---
//                Globals.actualStack.removeAll()
//                Globals.possibleStack.removeAll()
//                Globals.bruteForceStop = false
        
        //        Board.playerBoard.removeAll()
        //        Board().fullBoard.removeAll()
        
        //        // ----create empty cells----
        //        createEmptyCells(empty: numberOfEmptyCells)
        //        
        //        // ---convert the values in the actual array to a string---
        //        str  = ""
        //        for r in 0..<9 {
        //            for c in 0..<9 {
        //                str += String(Globals.actual[c][r])
        //            }
        //        }
        //        
        //        // ---verify the puzzle has only one solution---
        //        var tries = 0
        //        
        //        Globals.totalScore = 0
        //        
        //        repeat {
        //            if !SolvePuzzle.solvePuzzle() {
        //                // ---if puzzle is not solved and
        //                //    this is a level 1 to 3 puzzle---
        //                if level < 4 {
        //                    //---choose another pair of cells to empty---
        ////                    vacateAnotherPairOfCells(str: str)
        //                    tries += 1
        //                } else {
        //                    //---level 4 puzzles does not guarantee single
        //                    //   solution and potentially need guessing---
        //                    BruteForce.solvePuzzleByBruteForce()
        //                    break
        //                }
        //            } else {
        //                //---puzzle does indeed have 1 solution---
        //                break
        //            }
        //            // ---if too many tries, exit the loop---
        //            if tries > 50 {
        //                break
        //            }
        //        } while true
        //        //---return the score as well as the puzzle as a string---
        //        score = Globals.totalScore
        //        return (str, score)
//        Board().getPuzzle()
//    }
//}
    
    
    /*
    ============================================================
      Create empty cells in the grid
    ============================================================*/
//    static func createEmptyCells(empty: Int) {
//        var c = 0
//        var r = 0
//        
//        //----choose random locations for empty cells----
//        
//        var emptyCells = Array(Array(repeating: "", count: empty - 1))
//        for i in 0...Int(empty / 2) {
//            var duplicate = false
//            
//            repeat {
//                duplicate = false
//                //---get a cell in the first half of the grid
//                repeat {
//                    c = Int.random(in: 0...8)
//                    r = Int.random(in: 0...4)
//                } while (r == 4 && c > 4)
//                
//                for j in 0..<i {
//                    //---if cell is already selected to be empty
//                    if emptyCells[j] == String(c) + String(r) {
//                        duplicate = true
//                        break
//                    }
//                }
//                
//                if !duplicate {
//                    //---set the empty cell---
//                    emptyCells[i] = String(c) + String(r)
//                    Globals.actual[c][r] = 0
//                    Globals.possible[c][r] = ""
//                    //---reflect the top half of the grid and make it symmetrical---
//                    emptyCells[empty - 1 - i] = String(9 - c) + String(9 - c)
//                    Globals.actual[9 - c][9 - r] = 0
//                    Globals.possible[9 - c][9 - r] = ""
//                }
//            } while duplicate
//        }
//    }
            
    
    /*
    ============================================================
     Vacate another pair of cells
    ============================================================*/
//    static func vacateAnotherPairOfCells(str: String) {
//        var c = 0
//        var r = 0
//        
//        //---look for a pair of cells to restore---
//        repeat {
//            c = Int.random(in: 0..<9)
//            r = Int.random(in: 0..<9)
//        } while ((c - 1) + (r - 1) * 9) == 0
//        
//        //---restore the value of the cell from the actual_backup array---
//        
//        // str = str.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
//        
//        //                str = str.Remove((c - 1) + (r - 1) * 9, 1)
//        //                str = str.Insert((c - 1) + (r - 1) * 9, _
//        //                                 actual_backup(c, r).ToString())
//        
//        //---restore the value of the symmetrical cell from
//        //   the actual_backup array---
//        
//        //                str = str.Remove((10 - c - 1) + (10 - r - 1) * 9, 1)
//        //                str = str.Insert((10 - c - 1) + (10 - r - 1) * 9, _
//        //                                 actual_backup(10 - c, 10 - r).ToString())
//        //
//        //---look for another pair of cells to vacate---
//        repeat {
//            c = Int.random(in: 1...9)
//            r = Int.random(in: 1...9)
//        } while ((c - 1) + (r - 1) * 9) == 0
//        //                Do
//        //                c = RandomNumber(1, 9)
//        //                r = RandomNumber(1, 9)
//        //                Loop Until ((c - 1) + (r - 1) * 9) <> 0
//        //
//        
//        //                '---remove the cell from the str---
//        //                str = str.Remove((c - 1) + (r - 1) * 9, 1)
//        //                str = str.Insert((c - 1) + (r - 1) * 9, "0")
//        //
//        //                '---remove the symmetrical cell from the str---
//        //                str = str.Remove((10 - c - 1) + (10 - r - 1) * 9, 1)
//        //                str = str.Insert((10 - c - 1) + (10 - r - 1) * 9, "0")
//        //
//        //                '---reinitialize the board---
//        //                Dim counter As Integer = 0
//        //                For row As Integer = 1 To 9
//        //                For col As Integer = 1 To 9
//        //                If CInt(str(counter).ToString()) <> 0 Then
//        //                actual(col, row) = CInt(str(counter).ToString())
//        //                possible(col, row) = str(counter).ToString()
//        //                Else
//        //                actual(col, row) = 0
//        //                possible(col, row) = String.Empty
//        //                End If
//        //                counter += 1
//        //                Next
//        //                Next
//        //                End Sub
//        //                End Class
//    }
    
//}
