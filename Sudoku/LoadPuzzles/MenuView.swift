//
//  MenuView.swift
//  TrialMenuApp
//
//  Created by Alvin Alleyne on 3/26/24.
//

import SwiftUI


class DataModel {
    
    var content: [Puzzle]
    
    init() {
        content = puzArray.SudokuFiles
    }
}



struct MenuView: View {
    
    @State private var dm = DataModel()
    @State private var readFile = ""
//    @State private var count = 0
    @State private var selectedPuzzle = Puzzle(number: 0, name: "BruteForceEmpty", content: "")

    var body: some View {
        NavigationStack {
            Form() {
                Section(header: Text("SELECT THE PUZZLE TO LOAD OR SAVE")) {
                    VStack {
                        Picker("Please choose a puzzle:", selection: $selectedPuzzle) {
                            ForEach(dm.content, id: \.self) {
                                Text("\($0.number).  \($0.name)")
                            }
                        }
                    }
                }
                
                Text("FileName:  \(selectedPuzzle.name)")
                    .bold()

                
                Text("The files (puzzles) listed are the puzzles presented in the \"Programming SUDOKU\" book by Wei-Ming Lee.\n\nCRME are puzzles solved by Column, Row, and Minigrid elimination.\n\nThe remaining puzzles are listed by increasing difficulty - upto \"Brute Force\" methods.\n\nThe \"BruteForceEmpty\" puzzle is a blank puzzle that is solved by the computer and presented to the user.  The solutions are random and are selected by default.")
//                    .font(.system(size: 15, weight: .regular, design: .serif))
//                    .italic()
                    .font(.body)
                
                
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Menu {
                                Section("FILES:") {
                                    
                                    Button(action: { readFile = LoadAndSaveFiles.readFile(fileName: selectedPuzzle.name) }) {
                                        Label("Load a file", systemImage: "folder")
                                    }
                                    Button(action: { LoadAndSaveFiles.saveFile(fileName: selectedPuzzle.name, fileContents: selectedPuzzle.content) } ) {
                                        Label("Save a file", systemImage: "doc")
                                    }
                                }
//                                Section(header: Text("Secondary actions")) {
//                                    Button(action: { deleteFile() }) {
//                                        Label("Delete old files", systemImage: "trash")
//                                    }
//                                }
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
                
                Text("\n \(readFile)")
                    .padding(.horizontal)
                    .foregroundStyle(.green)
                
//                Spacer()
            }
        }
    }
}




#Preview {
    MenuView()
}

