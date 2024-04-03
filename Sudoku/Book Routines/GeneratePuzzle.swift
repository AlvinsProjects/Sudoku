//
//  GeneratePuzzle.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//

import Foundation


struct GeneratePuzzle {
    
    
    /*
     '============================================================
     ' Generate a random number between the specified range
     '============================================================
     Private Function RandomNumber(ByVal min As Integer, ByVal max As Integer) As Integer
     Return CType(Int((max - min + 1) * Rnd()) + min, Integer)
     End Function   */
    
    
    
    /*
    ============================================================
          Get Puzzle
    ============================================================*/
    public func getPuzzle(level: Int) -> String {
        var score = 0
        var result = ""
        
        repeat {
            result = generateNewPuzzle(level: level, score: score)
            if result != "" {
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
        return result
    }
    
    
    
    /*
    ============================================================
          Generate a new Sudoku puzzle
    ============================================================*/
    func generateNewPuzzle(level: Int, score: Int) -> String {
        
        var str = ""
        var numberOfEmptyCells = 0
        var score = score
        
        //'---initialize the entire board---
        for r in 0..<9 {
            for c in 0..<9 {
                Globals.actual[c][r] = 0
                Globals.possible[c][r] = ""
            }
        }
        
        // ---clear the stacks---
        //ActualStack.Clear()
        //PossibleStack.Clear()
        
        print(Globals.actual)
        print(Globals.possible)
        
        
        //'---populate the board with numbers by solving an empty grid---
        if !SolvePuzzle().solvePuzzle() {
            //---then use brute-force---
            MiscFuncs().solvePuzzleByBruteForce()
        } else {
            return "Error!"
        }
        
        
        //'---make a backup copy of the Actual array---
        //actual_backup = CType(actual.Clone(), Integer(,))
        
        //---set the number of empty cells based on the level of difficulty---
        switch level {
            case 1: numberOfEmptyCells = Int.random(in: 40...45)
            case 2: numberOfEmptyCells = Int.random(in: 46...49)
            case 3: numberOfEmptyCells = Int.random(in: 50...53)
            case 4: numberOfEmptyCells = Int.random(in: 54...58)
            default:
                break
        }
        
        //---clear the stacks that are used in brute-force elimination ---
        //ActualStack.Clear()
        //PossibleStack.Clear()
        
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
            if !SolvePuzzle().solvePuzzle() {
                // ---if puzzle is not solved and
                // this is a level 1 to 3 puzzle---
                if level < 4 {
                    //---choose another pair of cells to empty---
                    vacateAnotherPairOfCells(str: str)
                    tries += 1
                } else {
                    //---level 4 puzzles does not guarantee single
                    // solution and potentially need guessing---
                    MiscFuncs().solvePuzzleByBruteForce()
                    break
                }
            } else {
                //---puzzle does indeed have 1 solution---
                break
            }
            
            // ---if too many tries, exit the loop---
            if tries > 50 {
                return ""
            }
        } while true
        //---return the score as well as the puzzle as a string---
        score = Globals.totalScore
        return str
    }
    
    
    
    /*
    ============================================================
      Create empty cells in the grid
    ============================================================*/
    func createEmptyCells(empty: Int) {
//        var c = 0
//        var r = 0
        
        //    ----choose random locations for empty cells----
        //    var emptyCells(empty - 1) = ""
        
        //    Dim emptyCells(empty - 1) As String
        //    For i As Integer = 0 To (empty \ 2)
        //    Dim duplicate As Boolean
        //    Do
        //    duplicate = False
        //    '---get a cell in the first half of the grid
        //    Do
        //    c = RandomNumber(1, 9)
        //    r = RandomNumber(1, 5)
        //    Loop While (r = 5 And c > 5)
        //
        //    For j As Integer = 0 To i
        //    '---if cell is already selected to be empty
        //            If emptyCells(j) = c.ToString() & r.ToString() Then
        //            duplicate = True
        //            Exit For
        //            End If
        //            Next
        //
        //            If Not duplicate Then
        //            '---set the empty cell---
        //            emptyCells(i) = c.ToString() & r.ToString()
        //            actual(c, r) = 0
        //            possible(c, r) = String.Empty
        //            '---reflect the top half of the grid and make it symmetrical---
        //            emptyCells(empty - 1 - i) = _
        //            (10 - c).ToString() & (10 - r).ToString()
        //            actual(10 - c, 10 - r) = 0
        //            possible(10 - c, 10 - r) = String.Empty
        //            End If
        //            Loop While duplicate
        //            Next
        //            End Sub
    }
    
    
    
    /*
    ============================================================
     Vacate another pair of cells
    ============================================================*/
    func vacateAnotherPairOfCells(str: String) {
//        var c = 0
//        var r = 0
        
        //'---look for a pair of cells to restore---
        //                Do
        //                c = RandomNumber(1, 9)
        //                r = RandomNumber(1, 9)
        //                Loop Until ((c - 1) + (r - 1) * 9) = 0
        //
        //                '---restore the value of the cell from the actual_backup array---
        //                str = str.Remove((c - 1) + (r - 1) * 9, 1)
        //                str = str.Insert((c - 1) + (r - 1) * 9, _
        //                                 actual_backup(c, r).ToString())
        //
        //                '---restore the value of the symmetrical cell from
        //                ' the actual_backup array---
        //                str = str.Remove((10 - c - 1) + (10 - r - 1) * 9, 1)
        //                str = str.Insert((10 - c - 1) + (10 - r - 1) * 9, _
        //                                 actual_backup(10 - c, 10 - r).ToString())
        //
        //                '---look for another pair of cells to vacate---
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
