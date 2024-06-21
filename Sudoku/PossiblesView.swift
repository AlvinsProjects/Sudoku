//
//  PossiblesView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 5/4/24.
//

import SwiftUI



struct PossiblesView: View {
    
    @State private var board = Board() 
    let spacing = 2.0
    
    @State private var getNumbers = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                let difficultyColorIcon = ContentView().getHeaderColor(difficulty: "\(Globals.bdDifficulty)")
                let col = difficultyColorIcon.col
                let icon = difficultyColorIcon.icon
                
                let diff = "\(board.difficulty.rawValue * 2),  \(Globals.bdDifficulty)"
                
                // call headerView to display header - common to possiblesView
                HeaderView(diff: diff,
                           puzzName: Globals.puzzName,
                           exTime: Globals.exTime[0],
                           col: col,
                           icon: icon)
                .padding(.bottom, 8)
                
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
                
                //Selection numbers at the base of the puzzle
                HStack {
                    ForEach(1..<10) { i in
                        Text("\(i) ")
                            .frame(maxWidth: .infinity)
                            .font(.largeTitle)
                            .foregroundStyle(.blue).opacity(0.4)
                    }
                }
                Spacer()
                
            }
            .navigationTitle("Possible Cell Values")
        }
    }
}
    



#Preview {
    PossiblesView()
}
