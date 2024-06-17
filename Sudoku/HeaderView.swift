//
//  HeaderView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 6/17/24.
//

import SwiftUI

struct HeaderView: View {
    
    var diff =  ""
    var puzzName = ""
    var exTime = ""
    
    var body: some View {
        Grid {
            Grid(alignment: .leading, horizontalSpacing: 30, verticalSpacing: 4) {
                GridRow {
                    Text("Puzzle Name:")
                    Text(puzzName)
                }
                
                GridRow {
                    Text("Difficulty:")
                    Text(diff)
                }
                
                GridRow {
                    Text("Computer Solve Time:")
                    Text("\(exTime)")
                }
                
                GridRow {
                    Text("Puzzle Solve Time:")
                    Text("0h:23m:45s")
                }
            }
            .font(.footnote)
            .padding(10)
            .border(Color.secondary)
        }
    }
}







#Preview {
//    HeaderView()
    HeaderView(diff: "ooo")
}
