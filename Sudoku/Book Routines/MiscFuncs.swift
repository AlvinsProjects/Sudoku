//
//  MiscFuncs.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation


struct MiscFuncs {
    
    
    //=========================================================
    //   Find the cell with the small number of possible values
    //=========================================================
    func findCellWithFewestPossibleValues(col: Int, row: Int) {
        var min = 10
        for r in 0..<9 {
            for c in 0..<9 {
                if Vars.actual[c][r] == 0 && Vars.possible[c][r].count < min {
                    min = Vars.possible[c][r].count
                    Vars.col = c
                    Vars.row = r
                }
            }
        }
    }
    
    
    // ==================================================
    //      Solve puzzle by brute force
    // ==================================================
    func solvePuzzleByBruteForce() {
        var c = 0
        var r = 0
        
        // ---accumulate the total score---
        Vars.totalScore += 5
        
        // ---find out which cell has the smallest number of possible values---
        findCellWithFewestPossibleValues(col: c, row: r)
        
        // ---get the possible values for the chosen cell---
        var possibleValues = Vars.possible[c][r]
        
        // ---randomize the possible values----
        randomizeThePossibleValues(str: possibleValues)
        //    '-------------------
        //
        //    '---push the actual and possible stacks into the stack---
        //    ActualStack.Push(CType(actual.Clone(), Integer(,)))
        //    PossibleStack.Push(CType(possible.Clone(), String(,)))
        //
        //    '---select one value and try---
        //    For i As Integer = 0 To possibleValues.Length - 1
        //    actual(c, r) = CInt(possibleValues(i).ToString())
        //    Try
        //    If SolvePuzzle() Then
        //    '---if the puzzle is solved, the recursion can stop now---
        //            BruteForceStop = True
        //            Return
        //            Else
        //            '---no problem with current selection, proceed with next
        //            ' cell---
        //            SolvePuzzleByBruteForce()
        //            If BruteForceStop Then Return
        //            End If
        //            Catch ex As Exception
        //            '---accumulate the total score---
        //            totalscore += 5
        //            actual = ActualStack.Pop()
        //            possible = PossibleStack.Pop()
        //            End Try
        //            Next
        //            End Sub
    }
    
    
    
    // ==================================================
    //   Check if the puzzle is solved
    // ==================================================
    func isPuzzleSolved() -> Bool {
        var pattern = ""
        
        // ---check row by row---
        for r in 0..<9 {
            pattern = "123456789"
            for c in 0..<9 {
                pattern = pattern.replacingOccurrences(of: String(Vars.actual[c][r]), with: "")
            }
            if pattern.count > 0 {
                return false
            }
        }
        
        // ---check column by column---
        for c in 0..<9 {
            pattern = "123456789"
            for r in 0..<9 {
                pattern = pattern.replacingOccurrences(of: String(Vars.actual[c][r]), with: "")
            }
            if pattern.count > 0 {
                return false
            }
        }
        
        // ---check by minigrid---
        for c in stride(from: 0, through: 8, by: 3) {
            pattern = "123456789"
            for r in stride(from: 0, through: 8, by: 3) {
                for cc in 0...2 {
                    for rr in 0...2 {
                        pattern = pattern.replacingOccurrences(of: String(Vars.actual[c + cc][r + rr]), with: "")
                    }
                }
            }
            if pattern.count > 0 {
                return false
            }
        }
        return true
    }
    
    
    //=========================================================
    // Randomly swap the list of possible values
    //=========================================================
    func randomizeThePossibleValues(str: String) {
        //    var s[str.count - 1] = ""
        
        //    var i = 0
        //    var j = 0
        //    var temp = ""
        
        //Dim s(str.Length - 1) As Char
        //Dim i, j As Integer
        //Dim temp As Char
        //Randomize()
        //s = str.ToCharArray
        //For i = 0 To str.Length - 1
        //j = CInt((str.Length - i + 1) * Rnd() + i) Mod str.Length
        //'---swap the chars---
        //temp = s(i)
        //s(i) = s(j)
        //s(j) = temp
        //Next i
        //str = s
        //End Sub
    }
    
    
    
    
    //'============================================================
    //' Generate a random number between the specified range
    //'============================================================
    //Private Function RandomNumber(ByVal min As Integer, ByVal max As Integer) As Integer
    //Return CType(Int((max - min + 1) * Rnd()) + min, Integer)
    //End Function
    
    
    
}
