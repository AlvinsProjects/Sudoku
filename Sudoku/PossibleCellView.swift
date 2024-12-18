//
//  PossibleCellView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 5/4/24.
//

import SwiftUI


struct PossibleCellView: View {
    
    var number: String

    var displayPoss: [String] {
        var numArray = Array(repeating: "", count: 9)
        var location = 0
                        
        for j in 0..<number.count {
            location = Triplets.getNo(str: number, item: j) - 1
            numArray[location] = String(Triplets.getNo(str: number, item: j))
        }
        // Add a space for "" to fix display of candidate numbers
        for j in 0..<9 {
            if numArray[j] == "" { numArray[j] = " " }
        }
        
        return numArray
    }
    
    
    var body: some View {
        
        Grid {
            GridRow(alignment: .top) {
                Text(displayPoss[0])
                    .gridColumnAlignment(.trailing)
                Text(displayPoss[1])
                Text(displayPoss[2])
            }
            
            GridRow(alignment: .top) {
                Text(displayPoss[3])
                Text(displayPoss[4])
                Text(displayPoss[5])
            }
            
            GridRow(alignment: .top) {
                Text(displayPoss[6])
                Text(displayPoss[7])
                Text(displayPoss[8])
            }
        }
        .font(.system(size: 10, weight: .bold, design: .monospaced))
        .padding(.horizontal, 2)
        .foregroundStyle(.cyan).bold()
        .frame(maxWidth: 100, maxHeight: 100)
        .aspectRatio(1, contentMode: .fit)
//        .background(Color.squareStandard)
//        .background(.gray)
        .accessibilityShowsLargeContentViewer()
    }
}


#Preview {
    PossibleCellView(number: "812347659")
        .preferredColorScheme(.dark)
}
