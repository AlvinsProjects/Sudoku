//
//  Color-Cells.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import SwiftUI


extension Color {

    // an unselected square
    static let squareStandard = Color(red: 0.22, green: 0.25, blue: 0.3)
    
    // the square that is currently active for input
    static let squareSelected = Color.blue
    
    // a square in the same row or column as our selected square
    static let squareHighlighted = Color(red: 0.1, green: 0.15, blue: 0.2)
    
    // text for a square with the correct number
    static let squareTextCorrect = Color.white
    
    // same, but for the wrong number
    static let squareTextWrong = Color.red
    
    // text for a square that has the same number as our selected square
    static let squareTextSame = Color.orange
    
    // background color of cells with no number
    static let squareOpen = Color(red: 0.38, green: 0.38, blue: 0.44) //Color.gray
    
    // Numbers under the puzzle - for data entry
    static let hintMode = Color.yellow
    
}
