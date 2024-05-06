//
//  PossiblesView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 5/4/24.
//

import SwiftUI



struct PossiblesView: View {
    
    @State private var board = Board() //Board(difficulty: .Medium)
    let spacing = 2.0
    
    @State private var getNumbers = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                let textCol = ContentView().getHeaderColor(difficulty: "\(board.difficulty)")
                Text("  Difficulty:   \(board.difficulty)   \(textCol.icon)  ")
                    .font(.title)
                    .background(textCol.col)
                    .clipShape(.capsule)
                Text("Difficulty = \(board.difficulty.rawValue * 2)")
                Text(Globals.exTime)
            
                GridLayout(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<9) { row in
                        GridRow {
                            ForEach(0..<9) { col in
                                PossibleCellView(number: Globals.GlobePlayers[row][col])
                                
                                if col == 2 || col == 5 {
                                    Spacer()
                                        .frame(width: spacing, height: 1)
                                }
                            }
                        }
                        .padding(.bottom, row == 2 || row == 5 ? spacing : 0)
                    }
                }
                .padding(5)
                
                HStack {
                    ForEach(0..<9) { i in
                        Text("\(i) ")
                            .frame(maxWidth: .infinity)
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                    }
                }
                .padding(5)
                Spacer()
            }
            .navigationTitle("Possible Cell Values")
        }
    }
}
    



#Preview {
    PossiblesView()
}
