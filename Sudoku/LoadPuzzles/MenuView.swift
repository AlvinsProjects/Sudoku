//
//  MenuView.swift
//  TrialMenuApp
//
//  Created by Alvin Alleyne on 3/26/24.
//

import SwiftUI


@Observable
class DataModel {
    
    var content: [Puzzle]
    var index = 0
    
    init() {
        content = puzArray.SudokuFiles
        index = Globals.puzIndex
    }
}



struct MenuView: View {
    
    @State private var dm = DataModel()
    @State private var readFile = ""
//    @State private var count = 0
    @State private var puzzle = puzArray.SudokuFiles[12]
    @State private var index = 0
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form() {
                Section(header: Text("SELECT THE PUZZLE TO LOAD OR SAVE")) {
                    VStack {
                        Picker("Please choose a puzzle:", selection: $puzzle) {
                            ForEach(dm.content, id: \.self) {
                                Text("\($0.number). \($0.name)")
                            }
                        }
                    }
                }
                Section(header: Text("AVAILABLE PUZZLES")) {
//                    Text("Selected:    \(selectedPuzzle.number).  \(selectedPuzzle.name)").bold()
                    
                    Text("The files (puzzles) listed are the puzzles presented in the \"Programming SUDOKU\" book by Wei-Ming Lee.\n\nCRME are puzzles solved by Column, Row, and Minigrid elimination.\n\nThe remaining puzzles are listed by increasing difficulty - upto \"Brute Force\" methods.\n\nThe \"BruteForceEmpty\" puzzle is a blank puzzle that is solved by the computer and presented to the user.  BruteForce is the default setting and it generates random puzzles.\n\nIn order of difficulty, the computer solution methods are:\n\n1.  CRME\n2.  Lone Rangers\n3.  Twins\n4.  Triplets\n5.  Brute Force.")
                        .font(.system(size: 15, weight: .regular, design: .serif))
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Section("FILES:") {
                            
                            Button(action: { readFile = LoadAndSaveFiles.readFile(fileName: puzzle.name) }) {
                                Label("Load a file", systemImage: "folder")
                            }
                            Button(action: { LoadAndSaveFiles.saveFile(fileName: puzzle.name, fileContents: puzzle.content) } ) {
                                Label("Save a file", systemImage: "doc")
                            }
                        }
                        Section(header: Text("Secondary actions")) {
                            Button(action: { puzNum(puzzle: puzzle)}) {
                                Label("Create new puzzle", systemImage: "trash")
                            }
                        }
                    }
                label: {
                    VStack {
                        Text(Image(systemName: "folder"))
                        Text("File Menu")
                            .font(.footnote)
                    }
                }
                }
            }
            .navigationTitle("Puzzle Selection")
        }
    }

    
    func puzNum(puzzle: Puzzle) {
        print(puzzle.number, puzzle.name, puzzle.content)
        Globals.puzzle = puzzle
        Globals.puzIndex = puzzle.number
        
//        return
        
//        selectedPuzzle.number = index
//        TestPuzzle.getTestPuzzle()
//        Board().getNewPuzzle()
//        ContentView().newGame(difficulty: .Medium)
        dismiss()
    }
}




#Preview {
    MenuView()
}

