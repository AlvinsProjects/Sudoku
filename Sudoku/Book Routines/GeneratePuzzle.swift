//
//  GeneratePuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//

import Foundation


struct GeneratePuzzle {
    
    /*
    ============================================================
        Get Puzzle
    ============================================================*/
    static func getPuzzle(level: Int) -> String {
        var score = 0
        var result = (str: "", score: 0)
        
        repeat {
            result = generateNewPuzzle(level: level, score: score)
            score = result.score
            print(result.score)
            
            if result.str != "" {
                //---check if puzzle matches the level of difficulty---
                switch level {
                    case 1:
                        if score >= 42 && score <= 46 { break }     //Average 44
                    case 2:
                        if score >= 49 && score <= 53 { break }     //Average 51
                    case 3:
                        if score >= 56 && score <= 60 { break }     //Average 58
                    case 4:
                        if score >= 112 && score <= 116 { break }   //Average 114
                    default:
                        break
                }
            }
        } while true
        
        return result.str  //(from a tuple)
    }
    
    
    
    /*
    ============================================================
          Generate a new Sudoku puzzle
    ============================================================*/
    static func generateNewPuzzle(level: Int, score: Int) -> (str: String, score: Int) {
        
        var str = ""
        var numberOfEmptyCells = 0
        var score = score
        
        //---initialize the entire board---
        for r in 0..<9 {
            for c in 0..<9 {
                Globals.actual[c][r] = 0
                Globals.possible[c][r] = ""
            }
        }
        
        //---clear the stacks---
        Globals.actualStack.removeAll()
        Globals.possibleStack.removeAll()
        
        
        //---populate the board with numbers by solving an empty grid---
        if !SolvePuzzle.solvePuzzle() {
            //MARK: ---then use bruteforce---
            MiscFuncs.solvePuzzleByBruteForce()
        } else {
            print("Error!")
        }
        
        
        //---make a backup copy of the Actual array---
        Globals.actualBackup = Globals.actual
        //actual_backup = CType(actual.Clone(), Integer(,))
        
        //---set the number of empty cells based on the level of difficulty---
        switch level {
            case 1: numberOfEmptyCells = Int.random(in: 40...45)
            case 2: numberOfEmptyCells = Int.random(in: 46...49)
            case 3: numberOfEmptyCells = Int.random(in: 50...53)
            case 4: numberOfEmptyCells = Int.random(in: 54...58)
            default:
                print("Error at line 87 of generateNewPuzzle")
                break
        }
        
        //---clear the stacks that are used in brute-force elimination ---
        Globals.actualStack.removeAll()
        Globals.possibleStack.removeAll()
        Globals.bruteForceStop = false
        
        // ----create empty cells----
        createEmptyCells(empty: numberOfEmptyCells)
        
        // ---convert the values in the actual array to a string---
        str  = ""
        for r in 0..<9 {
            for c in 0..<9 {
                str = String(Globals.actual[c][r])
            }
        }
        
        // ---verify the puzzle has only one solution---
        var tries = 0
        
        Globals.totalScore = 0
        
        repeat {
            if !SolvePuzzle.solvePuzzle() {
                // ---if puzzle is not solved and
                //    this is a level 1 to 3 puzzle---
                if level < 4 {
                    //---choose another pair of cells to empty---
                    vacateAnotherPairOfCells(str: str)
                    tries += 1
                } else {
                    //---level 4 puzzles does not guarantee single
                    //   solution and potentially need guessing---
                    MiscFuncs.solvePuzzleByBruteForce()
                    break
                }
            } else {
                //---puzzle does indeed have 1 solution---
                break
            }
            // ---if too many tries, exit the loop---
            if tries > 50 {
                break
            }
        } while true
        //---return the score as well as the puzzle as a string---
        score = Globals.totalScore
        return (str, score)
    }
    
    
    
    /*
    ============================================================
      Create empty cells in the grid
    ============================================================*/
    static func createEmptyCells(empty: Int) {
        var c = 0
        var r = 0
        
        //----choose random locations for empty cells----
        
        var emptyCells = Array(Array(repeating: "", count: empty - 1))
        for i in 0...Int(empty / 2) {
            var duplicate = false
            
            repeat {
                duplicate = false
                //---get a cell in the first half of the grid
                repeat {
                    c = Int.random(in: 1...9)
                    r = Int.random(in: 1...5)
                } while (r == 5 && c > 5)
                
                for j in 0...i {
                    //---if cell is already selected to be empty
                    if emptyCells[j] == String(c) + String(r) {
                        duplicate = true
                        break
                    }
                }
                
                if !duplicate {
                    //---set the empty cell---
                    emptyCells[i] = String(c) + String(r)
                    Globals.actual[c][r] = 0
                    Globals.possible[c][r] = ""
                    //---reflect the top half of the grid and make it symmetrical---
                    emptyCells[empty - 1 - i] = String(10 - c) + String(10 - c)
                    Globals.actual[10 - c][10 - r] = 0
                    Globals.possible[10 - c][10 - r] = ""
                }
            } while duplicate
        }
    }
            
    
    /*
    ============================================================
     Vacate another pair of cells
    ============================================================*/
    static func vacateAnotherPairOfCells(str: String) {
        var c = 0
        var r = 0
        
        //---look for a pair of cells to restore---
        repeat {
            c = Int.random(in: 0..<9)
            r = Int.random(in: 0..<9)
        } while ((c - 1) + (r - 1) * 9) == 0
        
        //---restore the value of the cell from the actual_backup array---
        
        //MARK: // str = str.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
        
        //                str = str.Remove((c - 1) + (r - 1) * 9, 1)
        //                str = str.Insert((c - 1) + (r - 1) * 9, _
        //                                 actual_backup(c, r).ToString())
        
        //---restore the value of the symmetrical cell from
        //   the actual_backup array---
        
        //                str = str.Remove((10 - c - 1) + (10 - r - 1) * 9, 1)
        //                str = str.Insert((10 - c - 1) + (10 - r - 1) * 9, _
        //                                 actual_backup(10 - c, 10 - r).ToString())
        //
        //---look for another pair of cells to vacate---
        repeat {
            c = Int.random(in: 1...9)
            r = Int.random(in: 1...9)
        } while ((c - 1) + (r - 1) * 9) == 0
        //                Do
        //                c = RandomNumber(1, 9)
        //                r = RandomNumber(1, 9)
        //                Loop Until ((c - 1) + (r - 1) * 9) <> 0
        //
        
        //                '---remove the cell from the str---
        //                str = str.Remove((c - 1) + (r - 1) * 9, 1)
        //                str = str.Insert((c - 1) + (r - 1) * 9, "0")
        //
        //                '---remove the symmetrical cell from the str---
        //                str = str.Remove((10 - c - 1) + (10 - r - 1) * 9, 1)
        //                str = str.Insert((10 - c - 1) + (10 - r - 1) * 9, "0")
        //
        //                '---reinitialize the board---
        //                Dim counter As Integer = 0
        //                For row As Integer = 1 To 9
        //                For col As Integer = 1 To 9
        //                If CInt(str(counter).ToString()) <> 0 Then
        //                actual(col, row) = CInt(str(counter).ToString())
        //                possible(col, row) = str(counter).ToString()
        //                Else
        //                actual(col, row) = 0
        //                possible(col, row) = String.Empty
        //                End If
        //                counter += 1
        //                Next
        //                Next
        //                End Sub
        //                End Class
    }
    
}
