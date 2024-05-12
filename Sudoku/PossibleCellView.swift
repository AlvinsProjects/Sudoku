//
//  PossibleCellView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 5/4/24.
//

import SwiftUI

struct PossibleCellView: View {
    
    var number: String

    var displayPoss: String {
        var newNo = ""
        var numArray = Array(repeating: " ", count: 9)
        var location = 0
        
        for j in 0..<number.count {
            location = Triplets.getNo(str: number, item: j) - 1
            numArray[location] = String(Triplets.getNo(str: number, item: j))
        }
        
        for k in 0..<9  {
            if numArray[k] == " " { newNo += " " }
            if k == 3 || k == 6 { newNo += "\n"}
            newNo += numArray[k] + " "
        }
        return newNo
    }
    
    
    var body: some View {
        Text(displayPoss)
            .font(.caption2).bold()
            .foregroundStyle(.white)
            .frame(maxWidth: 100, maxHeight: 100)
            .aspectRatio(1, contentMode: .fit)
            .border(Color.gray, width: 1)
            .background(Color.squareStandard)
            .accessibilityShowsLargeContentViewer()
    }
}


#Preview {
    PossibleCellView(number: "123456789")
}