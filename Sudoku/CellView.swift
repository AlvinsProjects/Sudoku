//
//  CellView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import SwiftUI


struct CellView: View {
    
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
    var onSelected: () -> Void
    
    var displayNumber: String {
        if number == 0 {
            return ""
        } else {
            return String(number)
        }
    }
    
    
    var backgroundCol: Color {
        if number == 0 {
            return .squareOpen
        } else {
            return .squareStandard
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
        ZStack {
            Button(action: onSelected) {
                Text(displayNumber)
                    .font(.title)
                    .foregroundStyle(foregroundColor)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .aspectRatio(1, contentMode: .fit)
                    .background(highlightState.color)
            }
            .buttonStyle(.plain)
            .accessibilityShowsLargeContentViewer()
            
            
//            Text("1 2 3\n4 5 6\n789")
//                .font(.system(size: 10, weight: .bold, design: .monospaced))
//                .multilineTextAlignment(.leading)
//                .padding(.leading, 5)
//                .bold()
//                .foregroundStyle(.yellow)
        }
    }
}



#Preview {
    CellView(number: 3,
             selectedNumber: 3,
             highlightState: .standard,
             isCorrect: true,
             onSelected: { } )
}
