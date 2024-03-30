//
//  ContentView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import SwiftUI


struct ContentView: View {
    @State private var board = Board(difficulty: .Trivial)
    let spacing = 1.0
    
    @State private var selectedRow = -1
    @State private var selectedCol = -1
    @State private var selectedNum = 0
    
    @State private var solved = false
    @State private var showingNewGame = false
    
    @State private var counts = [Int: Int]()
    
    var body: some View {
        NavigationStack {
            VStack {
                let textCol = getHeaderColor(difficulty: "\(board.difficulty)")
                Text("Difficulty:   \(board.difficulty)   \(textCol.icon) ")
                    .font(.title)
                    .foregroundStyle(textCol.col)
                
                GridLayout(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<9) { row in
                        GridRow {
                            ForEach(0..<9) { col in
                                CellView(number: board.playerBoard[row][col],
                                         selectedNumber: selectedNum,
                                         highlightState: highlightState(for: row, col: col),
                                         isCorrect: board.playerBoard[row][col] == board.fullBoard[row][col]) {
                                    selectedRow = row
                                    selectedCol = col
                                    selectedNum = board.playerBoard[row][col]
                                }
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
                    ForEach(1..<10) { i in
                        Button(String(i)) {
                            enter(i)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .opacity(counts[i, default: 0] == 9 ? 0 : 1)
                    }
                }
                .padding()
            }
            .navigationTitle("Sudoku")
            .toolbar {
                Button {
                    showingNewGame = true
                } label: {
                    Label("Start a new game", systemImage: "plus")
                }
            }
        }
        .preferredColorScheme(.dark)
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        
        .alert("Start a new game", isPresented: $showingNewGame) {
            ForEach(Board.Difficulty.allCases, id: \.self) { difficulty in
                Button(String(describing: difficulty).capitalized) {
                    newGame(difficulty: difficulty)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            if solved {
                Text("You solved the board correctly - goood job!")
            }
        }
        .onAppear(perform: updateCounts)
        .onChange(of: board, initial: true) {
            updateCounts()
        }
//        .onTapGesture {
//            print(self.$selectedRow.wrappedValue, self.$selectedCol.wrappedValue)
//        }
    }
    
    
    func highlightState(for row: Int, col: Int) -> CellView.HighlightState {
        if row == selectedRow {
            if col == selectedCol {
                return .selected
            } else {
                return .highlighted
            }
        } else if col == selectedCol {
            return .highlighted
        } else {
            return .standard
        }
    }
    
    
    func enter(_ number: Int) {
        if selectedRow != -1 {         //Square must be selected
            if board.playerBoard[selectedRow][selectedCol] == number {
                board.playerBoard[selectedRow][selectedCol] = 0
                selectedNum = 0
            } else {
                board.playerBoard[selectedRow][selectedCol] = number
                selectedNum = number
            }
        }
    }
    
    
    func newGame(difficulty: Board.Difficulty) {
        board = Board(difficulty: difficulty)
        selectedRow = -1
        selectedCol = -1
        selectedNum = 0
    }
    
    
    func updateCounts() {
        solved = false
        var newCounts = [Int: Int]()
        var correctCount = 0
        
        for row in 0..<board.size {
            for col in 0..<board.size {
                let value = board.playerBoard[row][col]
                
                if value == board.fullBoard[row][col] {
                    newCounts[value, default: 0] += 1
                    correctCount += 1
                }
            }
        }
        counts = newCounts
        
        if correctCount == board.size * board.size {
            Task {
                try await Task.sleep(for: .seconds(1.0))
                showingNewGame = true
                solved = true
            }
        }
    }
    
    
    func getHeaderColor(difficulty: String) -> (col: Color, icon: String) {
        var col = Color.red
        var icon = ""
        switch difficulty {
            case "Trivial":
                col = Color.cyan
                icon = "😃"
            case "Easy":
                col = Color.green
                icon = "☺️"
            case "Medium":
                col = Color.yellow
                icon = "🥸"
            case "Hard":
                col = Color.orange
                icon = "😠"
            case "Extreme":
                col = Color.red
                icon = "😡"
            default:
                col = Color.orange
                icon = ""
        }
        return (col, icon)
    }
}



#Preview {
    ContentView()
}

