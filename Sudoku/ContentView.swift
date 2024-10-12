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
    @State private var pencilString = ""
    @State private var hints = ""
    @State private var showCandidates = true
    var puzzName = Globals.puzzName
    
    
    // Following 3 vars are data used in call to display the header
    var diff: String  {
        var dif = ""
        let descr = getHeader(diff: Globals.blanks)
        if Globals.puzIndex == 12 {
            dif = "Difficulty:  \(board.difficulty.rawValue * 2),  \(Globals.bdDifficulty)"
        } else {
            dif = "Difficulty:  \(Globals.blanks)  \(descr.difDescr)"
        }
        return dif
    }
    
    
//    var col: Color {
//        var color = Color.red
//        if Globals.puzIndex == 12 {
//            let colorIcon = getHeaderColor12(difficulty: "\(Globals.bdDifficulty)")
//            color = colorIcon.col
//        } else {
//            let ccc = getHeader(diff: Globals.blanks)
//            color = ccc.col
//        }
//        return color
//    }
    
    
//    var icon: String {
//        var ico = ""
//        if Globals.puzIndex == 12 {
//            let colorIcon = getHeaderColor12(difficulty: "\(Globals.bdDifficulty)")
//            ico = colorIcon.icon
//        } else {
//            let ccc = getHeader(diff: Globals.blanks)
//            ico = ccc.icon
//        }
//        return ico
//    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
//                Rectangle()
//                    .frame(width: 200, height: 10)   //108
//                    .foregroundStyle(.clear)
                
//                HeaderView()

                // call headerView to display header - common with possiblesView
//                HeaderView(diff: diff,
//                           puzzIndex: Globals.puzIndex,
//                           puzzName: Globals.puzzName,
//                           exTime: Globals.exTime[0],
//                           col: col,
//                           icon: icon)
//                .padding(.bottom, 8)

                VStack {
                    Text(diff)
                        .frame(width: 200, height: 10, alignment: .center)
                        .foregroundStyle(.cyan)
                        .padding(.top, 10)
                    TimerView()
                }
                .border(.secondary, width: 1)
                .padding(.bottom, 7)
                
                GridLayout(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<9) { row in
                        GridRow {
                            ForEach(0..<9) { col in
                                CellView(hintMode: $hintMode,
                                         number: board.playerBoard[row][col],
                                         selectedNumber: selectedNum,
                                         highlightState: highlightState(for: row, col: col),
                                         isCorrect: board.playerBoard[row][col] == board.fullBoard[row][col],
                                         pencilString: board.pencilBoard[row][col]) {
                                    
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
                
                
                // draw numbers below puzzle for entering data
                HStack {
                    ForEach(1..<10) { i in
                        Button(String(i)) {
                            enter(i)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .foregroundStyle(hintMode ? .yellow : .blue)
                        // hide the numbers that are no longer available
                        .opacity(counts[i, default: 0] == 9 ? 0.4 : 1)
                    }
                }
                
                // draw numbers to indicate quantities remaining to be solved
                HStack {
                    ForEach(counts.sorted(by: <), id: \.key) { key, value in
                        Text("\(value)")
                            .frame(width: 20, height: 20)
                            .border(.secondary)
                            .foregroundStyle(value == 9 ? .red : .green)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.caption)
                        .offset(y: -25)
                }
                
                
                // Insert toggle for entry of possible numbers
                Toggle("Enter Pencil Marks:",
                       systemImage: "square.grid.3x3",
                       isOn: $hintMode)
                .font(.title3)
                .foregroundStyle(hintMode ? .yellow : .secondary)
                .padding(.horizontal, 55)
                .offset(x: 0, y: -10)
                
                
                HStack {
                    // Button to toggle the display mode
                    Button(isDarkMode ? "Light Mode" : "Dark Mode") {
                        self.isDarkMode.toggle()
                    }
                    
                    // Navigate to load or save a new puzzle
                    NavigationLink("New Puzzle", destination: MenuView())
//                        .disabled(true)

                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle(puzzName)
            Spacer()
            
            //MARK: Top Toolbar
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        
                        //MARK: Display all possible numbers
                        Button {
                            showAllCandidates(isHidden: false)
                        } label: {
                            VStack {
                                Text(Image(systemName: "lightbulb.min.badge.exclamationmark"))
                                Text("Candidates")
                                    .font(.footnote)
                            }
                        }
                        
                        //MARK: Display the possible numbers for the selected cell
                        Button {
                            let c = self.$selectedCol.wrappedValue
                            let r = self.$selectedRow.wrappedValue
                            
                            // if no cell is selected, return
                            if c == -1 || r == -1 { return }
                            
                            // if selected cell has a value, return
                            if board.playerBoard[r][c] != 0 { return }
                            
                            // Re-set the variables
                            getNumbers = ""
                            newNo = ""
                            for j in 0..<9 {
                                numArray[j] = ""
                            }
                            
                            
                            // Get the numbers that are available for the selected cell
                            getNumbers = calculatePlayerBoardValues(col: r, row: c)
                            
                            // Arrange the numbers into a grid
                            for j in 0..<getNumbers.count {
                                location = Triplets.getNo(str: getNumbers, item: j) - 1
                                numArray[location] = String(Triplets.getNo(str: getNumbers, item: j))
                            }
                            for k in 0..<9  {
                                if numArray[k] == " " { newNo += "" }
                                if k == 3 || k == 6 { newNo += " \n"}
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
        .alert("Change Puzzle Difficulty", isPresented: $showingNewGame) {
            
            // if blank puzzle slected - allow choice of difficulty
            // puzIndex = 12 is a blank puzzle that generates random puzzles
            if Globals.puzIndex == 12 {
                ForEach(Board.Difficulty.allCases, id: \.self) { difficulty in
                    Button(String(describing: difficulty).capitalized) {
                        newGame(difficulty: difficulty)
                        Globals.bdDifficulty = difficulty
                    }
                }
            }
            
            Button {
                board.playerBoard = board.fullBoard
            } label: {
                Text("Solve the Puzzle")
                    .font(.footnote)
            }
            
            

//            NavigationLink {
//                HeaderView()
//            } label: {
//                Text("Header View")
//                    .font(.footnote)
//            }

            
            Button("Cancel", role: .cancel) { }
        } message: {
            if solved {
                Text("You solved the board correctly!")
            }
        }
        
        
        
        
        //MARK: Alert to show the numbers available for the selected cell
        .alert("Candidate Numbers", isPresented: $showingPossibles) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Numbers available for\nColumn \(self.selectedCol + 1), Row \(self.selectedRow + 1):\n\n\(getNumbers)")
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
        
        if selectedRow != -1 {  //Square must be selected
            
            // Don't allow original or correct numbers to be changed
            if board.playerBoard[selectedRow][selectedCol] == board.fullBoard[selectedRow][selectedCol] { return }
            
            if hintMode {
                // if hints number exists, delete it
                if board.pencilBoard[selectedRow][selectedCol] == "" {
                    pencilString = ""
                    hints = ""
                }
                let rawData = board.pencilBoard[selectedRow][selectedCol]
                // delete all whiteSpaces and "\n"s
                var hints = rawData.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
                
                if hints.contains(String(number)) {
                    hints = hints.replacingOccurrences(of: String(Triplets.getNo(str: String(number), item: 0)), with: "")
                } else {
                    hints += String(number)
                }
                board.pencilBoard[selectedRow][selectedCol] = hints
            } else {
                // Don't allow original or correct numbers to be changed
                if board.playerBoard[selectedRow][selectedCol] == number {
                    board.playerBoard[selectedRow][selectedCol] = 0
                    selectedNum = 0
                } else {
                    board.playerBoard[selectedRow][selectedCol] = number
                    selectedNum = number
                }
            }
            if !showCandidates {
                if !hintMode {
                    showAllCandidates(isHidden: true)
                }
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
                try await Task.sleep(for: .seconds(2.0))
                showingNewGame = true
                solved = true
            }
        }
    }
    
    func showAllCandidates(isHidden: Bool)  {
        if isHidden {
            showCandidates = true
        }
        
        if showCandidates {
            for j in 0..<9 {
                for k in 0..<9 {
                    board.pencilBoard[j][k] = calculatePlayerBoardValues(col: j, row: k)
                }
            }
        } else {
            for j in 0..<9 {
                for k in 0..<9 {
                    board.pencilBoard[j][k] = ""
                }
            }
        }
        showCandidates.toggle()
    }
    
    
    
    
    
//    func getHeaderColor12(difficulty: String) -> (col: Color, icon: String) {
//        var col = Color.red
//        var icon = ""
//        switch difficulty {
//            case "Trivial":
//                col = Color.cyan
//                icon = "😃"
//            case "Easy":
//                col = Color.green
//                icon = "☺️"
//            case "Medium":
//                col = Color.yellow
//                icon = "🥸"
//            case "Hard":
//                col = Color.orange
//                icon = "😠"
//            case "Extreme":
//                col = Color.pink
//                icon = "😡"
//            default:
//                col = Color.orange
//                icon = ""
//        }
//        return (col, icon)
//    }
    
    
    func getHeader(diff: Int) -> (col: Color, difDescr: String, icon: String){
        var col = Color.red
        var difDescription = ""
        var icon = ""
        switch diff {
            case 20...39:
                col = Color.cyan
                difDescription = "Trivial"
                icon = "😃"
            case 40...45:
                col = Color.green
                difDescription = "Easy"
                icon = "☺️"
            case 46...49:
                col = Color.yellow
                difDescription = "Medium"
                icon = "🥸"
            case 50...53:
                col = Color.orange
                difDescription = "Hard"
                icon = "😠"
            case 54...68:
                col = Color.pink
                difDescription = "Extreme"
                icon = "😡"
            default:
                col = Color.pink
                difDescription = "Extreme"
                icon = "😡"
        }
        return (col, difDescription, icon)
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
     =========================================================
       Calculates the possible values for a playerBoard cell
     =========================================================*/
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



