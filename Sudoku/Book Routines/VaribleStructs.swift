//
//  VaribleStructs.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//

import Foundation


struct Vars {
    
    
    static var actual = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
    static var possible = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    
    static var bruteForceStop = false
//'---used to store the state of the grid---
//    Private ActualStack As New Stack(Of Integer(,))()
//    Private PossibleStack As New Stack(Of String(,))()
    static var totalScore = 0
//    static var actualBackup = [[Int]]()
    static var col = 0
    static var row = 0
    
}
    
//    Private actual(9, 9) As Integer
//    
//    '---used to represent the possible values of cells in the grid---
//    Private possible(9, 9) As String
//    
//    '---indicate if the brute-force subroutine should stop---
//        Private BruteForceStop As Boolean = False
//        
//        '---used to store the state of the grid---
//        Private ActualStack As New Stack(Of Integer(,))()
//        Private PossibleStack As New Stack(Of String(,))()
//        
//        '---store the total score accumulated---
//        Private totalscore As Integer
//        
//        '---backup a copy of the Actual array---
//        Dim actual_backup(9, 9) As Integer
    
    

