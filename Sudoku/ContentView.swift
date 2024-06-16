//
//  ContentView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/24/24.
//

import SwiftUI



struct ContentView: View {
    
    @State private var board = Board()
    let spacing = 2.0
    
    @State private var selectedRow = -1
    @State private var selectedCol = -1
    @State private var selectedNum = 0
    @State private var solved = false
    @State private var showingNewGame = false
    @State private var showingPossibles = false
    @State private var getNumbers = ""
    @State private var isDarkMode = true
    @State private var counts = [Int: Int]()
    @State private var newNo = ""
    @State private var location = 0
    @State private var numArray = Array(repeating: "", count: 9)
    
    @State private var hintMode = false
    @State private var hints = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                let textCol = getHeaderColor(difficulty: "\(Globals.bdDifficulty)")
                
                Text("    Difficulty:      \(Globals.bdDifficulty)   \(textCol.icon)    ")
                    .font(.title)
                    .frame(height: 45)
                    .background(textCol.col)
                    .clipShape(.capsule)
                    .padding(.top, 5)
                Group {
                    Text("Puzzle Name:  \(Globals.puzzName)")
                    Text("Difficulty = \(board.difficulty.rawValue * 2)")
                    Text(Globals.exTime[0])
                }
                .font(.footnote)
                
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
                
                //draw numbers below puzzle for entering data
                HStack {
                    ForEach(1..<10) { i in
                        Button(String(i)) {
                            enter(i)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .foregroundColor(hintMode ? .yellow : .blue)
                        // hide the numbers that are no longer available
                        .opacity(counts[i, default: 0] == 9 ? 0 : 1)
                    }
                }

                // Insert toggle for entry of possible numbers
                Toggle("Enter Hints:",
                       systemImage: "square.grid.3x3",isOn: $hintMode)
                .font(.title3)
                .foregroundStyle(hintMode ? .yellow : .secondary)
                .padding(.horizontal, 90)
                .offset(x: 0, y: -10)
                
                HStack {
                    // Button to toggle the display mode
                    Button(isDarkMode ? "Light Mode" : "Dark Mode") {
                        self.isDarkMode.toggle()
                    }
                    // Navigate to load or save a new puzzle
                    NavigationLink("New Puzzle", destination: MenuView())
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Sudoku Puzzle")


            
            //MARK: Top Toolbar
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    //MARK: Display all possible numbers
                    NavigationLink {
                        PossiblesView()
                    } label: {
                        VStack {
                            Text(Image(systemName: "lightbulb.min.badge.exclamationmark"))
                            Text("Possibles")
                                .font(.footnote)
                        }
                    }
                    
                    //MARK: Display the possible numbers for the selected cell
                    Button {
                        let c = self.$selectedCol.wrappedValue
                        let r = self.$selectedRow.wrappedValue
                        
                        // if no cell is selected, return
                        if c == -1 || r == -1 { return }
                        
                        //if selected cell has a value, return
                        if board.playerBoard[r][c] != 0 { return }
                        
                        // Re-set the variables
                        getNumbers = ""
                        newNo = ""
                        for j in 0..<9 {
                            numArray[j] = ""
                        }
                        
                        // get the numbers that are available for the selected cell
                        getNumbers = calculatePlayerBoardValues(col: r, row: c)

                        // Arrange the numbers into a grid
                        for j in 0..<getNumbers.count {
                            location = Triplets.getNo(str: getNumbers, item: j) - 1
                            numArray[location] = String(Triplets.getNo(str: getNumbers, item: j))
                        }
                        for k in 0..<9  {
                            if numArray[k] == "" { newNo += "" }
                            if k == 3 || k == 6 { newNo += "\n"}
                            newNo += numArray[k] + " "
                        }
                        getNumbers = newNo

                        showingPossibles = true
                    } label: {
                        VStack {
                            Text(Image(systemName: "questionmark.circle.fill"))
                            Text("Hint")
                                .font(.footnote)
                        }
                    }
                    
                    //MARK: Display the steps taken by the computer solution of the puzzle
                    NavigationLink {
                        StepsTakenView()
                    } label: {
                        VStack {
                            Text(Image(systemName: "list.number"))
                            Text("Steps")
                                .font(.footnote)
                        }
                    }
                    
                    
                    //MARK: Add a new puzzle, change the difficulty, or cancel
                    Button {
                        Globals.totalScore = 0
                        showingNewGame = true
                    } label: {
                        VStack {
                            Text(Image(systemName: "plus"))
                            Text("Games")
                                .font(.footnote)
                        }
                    }
                }
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        
        .onAppear(perform: updateCounts)
        .onChange(of: board, initial: true) {
            updateCounts()
            updatePlayerBoard()
        }
        
        
        //MARK: Alert to allow changes in difficulty and to start a new game, or cancel
        .alert("Change Difficulty or \nStart a New Game", isPresented: $showingNewGame) {
            ForEach(Board.Difficulty.allCases, id: \.self) { difficulty in
                Button(String(describing: difficulty).capitalized) {
                    newGame(difficulty: difficulty)
                    Globals.bdDifficulty = difficulty
                }
            }
            
            Button {
                board.playerBoard = board.fullBoard
            } label: {
                Text("Solve the Puzzle")
                    .font(.footnote)
            }
            
            
            Button("Cancel", role: .cancel) { }
        } message: {
            if solved {
                Text("You solved the board correctly - goood job!")
            }
        }
        
        
        //MARK: Alert to show the numbers available for the selected cell
        .alert("Possible Numbers", isPresented: $showingPossibles) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Numbers available for this cell are:\n\n\(getNumbers)")
        }
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
        
        if selectedRow != -1 {   //Square must be selected
            
            // Don't allow any original number to be changed
            if board.playerBoard[selectedRow][selectedCol] == board.fullBoard[selectedRow][selectedCol] { return }
            
            if !hintMode {
                
                if board.playerBoard[selectedRow][selectedCol] == number {
                    board.playerBoard[selectedRow][selectedCol] = 0
                    selectedNum = 0
                } else {
                    board.playerBoard[selectedRow][selectedCol] = number
                    selectedNum = number
                }
            } //else {
//                hints += String(number)
//                print("\(number)  hello world  \(hints)")
                //                let demo = 12345
//                board.playerBoard[selectedRow][selectedCol] = number
//                selectedNum = number
                
                
//            }
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
                try await Task.sleep(for: .seconds(2.0))
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
                col = Color.blue
                icon = "☺️"
            case "Medium":
                col = Color.green
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
    
    
    func updatePlayerBoard() {
        var str = ""
        for c in 0..<9 {
            for r in 0..<9 {
                str = calculatePlayerBoardValues(col: c, row: r)
                Globals.GlobePlayers[c][r] = str
            }
        }
    }
    
    
    
    /*
     =====================================================
     Calculates the possible values for a playerBoard cell
     =====================================================*/
    func calculatePlayerBoardValues(col: Int, row: Int) -> String {
        var str = ""
        
        //if selected cell has a value, return
        if board.playerBoard[col][row] != 0 { return "" }
        
        if board.playerBoard[col][row] == 0 {
            str = "123456789"
        }
        
        //---Step (1) check by column---
        for r in 0..<9 {
            if board.playerBoard[col][r] != 0 {
                //---that means there is an actual value in it---
                str = str.replacingOccurrences(of: String(board.playerBoard[col][r]), with: "")
            }
        }
        
        //---Step (2) check by row---
        for c in 0..<9 {
            if board.playerBoard[c][row] != 0 {
                //---that means there is a actual value in it---
                str = str.replacingOccurrences(of: String(board.playerBoard[c][row]), with: "")
            }
        }
        
        //---Step (3) check within the minigrid---
        let startC = col - (col % 3)
        let startR = row - (row % 3)
        for rr in startR...startR + 2 {
            for cc in startC...startC + 2 {
                if board.playerBoard[cc][rr] != 0 {
                    //---that means there is an actual value in it---
                    str = str.replacingOccurrences(of: String(board.playerBoard[cc][rr]), with: "")
                }
            }
        }
        return str
    }
}



#Preview {
    ContentView()
}

