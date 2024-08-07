//
//  CellView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import SwiftUI


struct CellView: View {
    
    @Binding var hintMode: Bool
    
    enum HighlightState {
        case standard, highlighted, selected, open
        
        var color: Color {
            switch self {
                case .standard:
                    return .squareStandard
                case .highlighted:
                    return .squareHighlighted
                case .selected:
                    return .squareSelected
                case .open:
                    return .squareOpen
            }
        }
    }
    
    let number: Int
    let selectedNumber: Int
    let highlightState: HighlightState
    let isCorrect: Bool
    var pencilString = ""
    var onSelected: () -> Void

    
    var displayNumber: String {
        if number == 0 {
            return ""
        } else {
            return String(number)
        }
    }
    
    
    var foregroundColor: Color {
        if isCorrect {
            if number == selectedNumber {
                return .squareTextSame
            } else {
                return .squareTextCorrect
            }
        } else {
            return .squareTextWrong
        }
    }
    
    
    var body: some View {
        Button(action: onSelected) {
            
            ZStack {
                Text(displayNumber)
                    .font(.title)
                    .foregroundStyle(foregroundColor)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .aspectRatio(1, contentMode: .fit)
                    .background(highlightState.color)
                
                if displayNumber == "" {
                    PossibleCellView(number: pencilString)
                }
            }
            .buttonStyle(.plain)
            .accessibilityShowsLargeContentViewer()
        }
    }
}




#Preview {
    CellView(hintMode: .constant(false),
             number: 3,
             selectedNumber: 3,
             highlightState: .standard,
             isCorrect: true,
             onSelected: { } )
}

