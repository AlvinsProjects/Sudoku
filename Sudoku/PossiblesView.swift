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
    
    var diff: String  {
        var dif = ""
        let descr = ContentView().getHeader(diff: Globals.blanks)
        if Globals.puzIndex == 12 {
            dif = "\(board.difficulty.rawValue * 2),  \(Globals.bdDifficulty)"
        } else {
            dif = "\(Globals.blanks)  \(descr.difDescr)"
        }
        return dif
    }
    
    var col: Color {
        var color = Color.red
        if Globals.puzIndex == 12 {
            let colorIcon = ContentView().getHeaderColor12(difficulty: "\(Globals.bdDifficulty)")
            color = colorIcon.col
        } else {
            let ccc = ContentView().getHeader(diff: Globals.blanks)
            color = ccc.col
        }
        return color
    }
    
    var icon: String {
        var ico = ""
        if Globals.puzIndex == 12 {
            let colorIcon = ContentView().getHeaderColor12(difficulty: "\(Globals.bdDifficulty)")
            ico = colorIcon.icon
        } else {
            let ccTemp = ContentView().getHeader(diff: Globals.blanks)
            ico = ccTemp.icon
        }
        return ico
    }
    
    
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // call headerView to display header - common to possiblesView
                HeaderView(diff: diff,
                           puzzIndex: Globals.puzIndex,
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
