//
//  Triplets.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/28/24.
//

import Foundation

//
//'==================================================
//' Look for Triplets in Minigrids
//            '==================================================
//            Private Function LookForTripletsinMinigrids() As Boolean
func lookForTripletsInMinigrids() -> Bool {
    //            Dim changes As Boolean = False
    //
    //            '---check each cell---
    //            For r As Integer = 1 To 9
    //            For c As Integer = 1 To 9
    //
    //            '--- three possible values; check for triplets---
    //                                                    If actual(c, r) = 0 AndAlso possible(c, r).Length = 3 Then
    //
    //                                                    '---first potential triplet found---
    //                                                    Dim tripletsLocation As String = c.ToString() & r.ToString()
    //
    //                                                    '---scan by mini-grid---
    //                                                    Dim startC, startR As Integer
    //                                                    startC = c - ((c - 1) Mod 3)
    //                                                    startR = r - ((r - 1) Mod 3)
    //                                                    For rr As Integer = startR To startR + 2
    //                                                    For cc As Integer = startC To startC + 2
    //                                                    If (Not ((cc = c) AndAlso (rr = r))) AndAlso _
    //                                                    ((possible(cc, rr) = possible(c, r)) OrElse _
    //                                                     (possible(cc, rr).Length = 2 AndAlso _
    //                                                      possible(c, r).Contains( _
    //                                                                               possible(cc, rr)(0).ToString()) AndAlso _
    //                                                      possible(c, r).Contains( _
    //                                                                               possible(cc, rr)(1).ToString()))) Then
    //
    //                                                    '---save the coorindates of the triplets
    //                                                    tripletsLocation &= cc.ToString() & rr.ToString()
    //                                                    End If
    //                                                    Next
    //                                                    Next
    //
    //                                                    '--found 3 cells as triplets; remove all from the other
    //' cells---
    //If tripletsLocation.Length = 6 Then
    //
    //'---remove each cell's possible values containing the
    //' triplet---
    //For rrr As Integer = startR To startR + 2
    //For ccc As Integer = startC To startC + 2
    //
    //'---look for the cell that is not part of the
    //                ' 3 cells found---
    //                If actual(ccc, rrr) = 0 AndAlso _
    //                ccc <> CInt(tripletsLocation(0).ToString()) _
    //                AndAlso _
    //                rrr <> CInt(tripletsLocation(1).ToString()) _
    //                AndAlso _
    //                ccc <> CInt(tripletsLocation(2).ToString()) _
    //                AndAlso _
    //                rrr <> CInt(tripletsLocation(3).ToString()) _
    //                AndAlso _
    //                ccc <> CInt(tripletsLocation(4).ToString()) _
    //                AndAlso _
    //                rrr <> CInt(tripletsLocation(5).ToString()) Then
    //
    //                '---save the original possible values---
    //                Dim original_possible As String = _
    //                possible(ccc, rrr)
    //
    //                '---remove first triplet number from possible
    //                ' values---
    //                possible(ccc, rrr) = _
    //                possible(ccc, rrr).Replace( _
    //                                            possible(c, r)(0), String.Empty)
    //
    //                '---remove second triplet number from possible
    //                ' values---
    //                possible(ccc, rrr) = _
    //                possible(ccc, rrr).Replace( _
    //                                            possible(c, r)(1), String.Empty)
    //
    //                '---remove third triplet number from possible
    //                ' values---
    //                possible(ccc, rrr) = _
    //                possible(ccc, rrr).Replace( _
    //                                            possible(c, r)(2), String.Empty)
    //
    //                '---if the possible values are modified, then
    //                ' set the changes variable to true to indicate
    //                ' that the possible values of cells in the
    //                ' minigrid have been modified---
    //                If original_possible <> possible(ccc, rrr) Then
    //                changes = True
    //                End If
    //
    //                '---if possible value reduces to empty string,
    //                ' then the user has placed a move that results
    //                ' in the puzzle not solvable---
    //                If possible(ccc, rrr) = String.Empty Then
    //                Throw New Exception("Invalid Move")
    //                End If
    //
    //                '---if left with 1 possible value for the
    //                ' current cell, cell is confirmed---
    //                If possible(ccc, rrr).Length = 1 Then
    //                actual(ccc, rrr) = CInt(possible(ccc, rrr))
    //
    //                '---accumulate the total score---
    //                totalscore += 4
    //                End If
    //                End If
    //                Next
    //                Next
    //                End If
    //                End If
    //                Next
    //                Next
    //                Return changes
    //                End Function
    return true
}


//
//                '==================================================
//                ' Look for Triplets in Rows
//                '==================================================
//                Private Function LookForTripletsinRows() As Boolean
func lookForTripletsInRows() -> Bool {
    //                Dim changes As Boolean = False
    //
    //                '---for each row, check each column in the row---
    //                For r As Integer = 1 To 9
    //                For c As Integer = 1 To 9
    //
    //                '--- three possible values; check for triplets---
    //                                                        If actual(c, r) = 0 AndAlso possible(c, r).Length = 3 Then
    //
    //                                                        '---first potential triplet found---
    //                                                        Dim tripletsLocation As String = c.ToString() & r.ToString()
    //
    //                                                        '---scans columns in this row---
    //                                                        For cc As Integer = 1 To 9
    //
    //                                                        '---look for other triplets---
    //                                                        If (cc <> c) AndAlso _
    //                                                        ((possible(cc, r) = possible(c, r)) OrElse _
    //                                                         (possible(cc, r).Length = 2 AndAlso _
    //                                                          possible(c, r).Contains( _
    //                                                                                   possible(cc, r)(0).ToString()) AndAlso _
    //                                                          possible(c, r).Contains( _
    //                                                                                   possible(cc, r)(1).ToString()))) Then
    //
    //                                                        '---save the coorindates of the triplet---
    //                                                        tripletsLocation &= cc.ToString() & r.ToString()
    //                                                        End If
    //                                                        Next
    //
    //                                                        '--found 3 cells as triplets; remove all from the other
    //' cells---
    //If tripletsLocation.Length = 6 Then
    //
    //'---remove each cell's possible values containing the
    //' triplet---
    //For ccc As Integer = 1 To 9
    //If actual(ccc, r) = 0 AndAlso _
    //ccc <> CInt(tripletsLocation(0).ToString()) _
    //AndAlso _
    //ccc <> CInt(tripletsLocation(2).ToString()) _
    //AndAlso _
    //ccc <> CInt(tripletsLocation(4).ToString()) Then
    //
    //'---save the original possible values---
    //Dim original_possible As String = possible(ccc, r)
    //
    //'---remove first triplet number from possible
    //' values---
    //possible(ccc, r) = _
    //possible(ccc, r).Replace( _
    //                          possible(c, r)(0), String.Empty)
    //
    //'---remove second triplet number from possible
    //' values---
    //possible(ccc, r) = _
    //possible(ccc, r).Replace( _
    //                          possible(c, r)(1), String.Empty)
    //
    //'---remove third triplet number from possible
    //' values---
    //possible(ccc, r) = _
    //possible(ccc, r).Replace( _
    //                          possible(c, r)(2), String.Empty)
    //
    //'---if the possible values are modified, then set
    //        ' the changes variable to true to indicate that
    //        ' the possible values of cells in the minigrid
    //        ' have been modified---
    //        If original_possible <> possible(ccc, r) Then
    //        changes = True
    //        End If
    //
    //        '---if possible value reduces to empty string,
    //        ' then the user has placed a move that results
    //        ' in the puzzle not solvable---
    //        If possible(ccc, r) = String.Empty Then
    //        Throw New Exception("Invalid Move")
    //        End If
    //
    //        '---if left with 1 possible value for the current
    //        ' cell, cell is confirmed---
    //        If possible(ccc, r).Length = 1 Then
    //        actual(ccc, r) = CInt(possible(ccc, r))
    //
    //        '---accumulate the total score---
    //        totalscore += 4
    //        End If
    //        End If
    //        Next
    //        End If
    //        End If
    //        Next
    //        Next
    //        Return changes
    //        End Function
    return true
}



//
//        '==================================================
//        ' Look for Triplets in Columns
//        '==================================================
//        Private Function LookForTripletsinColumns() As Boolean
func lookForTripletsInColumns() -> Bool {
    //        Dim changes As Boolean = False
    //
    //        '---for each column, check each row in the column---
    //        For c As Integer = 1 To 9
    //        For r As Integer = 1 To 9
    //
    //        '--- three possible values; check for triplets---
    //                                                If actual(c, r) = 0 AndAlso possible(c, r).Length = 3 Then
    //
    //                                                '---first potential triplet found---
    //                                                Dim tripletsLocation As String = c.ToString() & r.ToString()
    //
    //                                                '---scans rows in this column---
    //                                                For rr As Integer = 1 To 9
    //                                                If (rr <> r) AndAlso _
    //                                                ((possible(c, rr) = possible(c, r)) OrElse _
    //                                                 (possible(c, rr).Length = 2 AndAlso _
    //                                                  possible(c, r).Contains( _
    //                                                                           possible(c, rr)(0).ToString()) AndAlso _
    //                                                  possible(c, r).Contains( _
    //                                                                           possible(c, rr)(1).ToString()))) Then
    //
    //                                                '---save the coorindates of the triplet---
    //                                                tripletsLocation += c.ToString() & rr.ToString()
    //                                                End If
    //                                                Next
    //
    //                                                '--found 3 cells as triplets; remove all from the other cells---
    //If tripletsLocation.Length = 6 Then
    //
    //'---remove each cell's possible values containing the
    //' triplet---
    //For rrr As Integer = 1 To 9
    //If actual(c, rrr) = 0 AndAlso _
    //rrr <> CInt(tripletsLocation(1).ToString()) _
    //AndAlso _
    //rrr <> CInt(tripletsLocation(3).ToString()) _
    //AndAlso _
    //rrr <> CInt(tripletsLocation(5).ToString()) Then
    //
    //'---save the original possible values---
    //Dim original_possible As String = possible(c, rrr)
    //
    //'---remove first triplet number from possible
    //' values---
    //possible(c, rrr) = _
    //possible(c, rrr).Replace( _
    //                          possible(c, r)(0), String.Empty)
    //
    //'---remove second triplet number from possible
    //' values---
    //possible(c, rrr) = _
    //possible(c, rrr).Replace( _
    //                          possible(c, r)(1), String.Empty)
    //
    //'---remove third triplet number from possible
    //' values---
    //possible(c, rrr) = _
    //possible(c, rrr).Replace( _
    //                          possible(c, r)(2), String.Empty)
    //
    //'---if the possible values are modified, then set
    //        ' the changes variable to true to indicate that
    //        ' the possible values of cells in the minigrid
    //        ' have been modified---
    //        If original_possible <> possible(c, rrr) Then
    //        changes = True
    //        End If
    //
    //        '---if possible value reduces to empty string,
    //        ' then the user has placed a move that results
    //        ' in the puzzle not solvable---
    //        If possible(c, rrr) = String.Empty Then
    //        Throw New Exception("Invalid Move")
    //        End If
    //
    //        '---if left with 1 possible value for the current
    //        ' cell, cell is confirmed---
    //        If possible(c, rrr).Length = 1 Then
    //        actual(c, rrr) = CInt(possible(c, rrr))
    //
    //        '---accumulate the total score---
    //        totalscore += 4
    //        End If
    //        End If
    //        Next
    //        End If
    //        End If
    //        Next
    //        Next
    //        Return changes
    //        End Function
    return true
}
