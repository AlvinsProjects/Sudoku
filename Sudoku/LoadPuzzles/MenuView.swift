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
                
                
                Button(action: { self.puzNum(puzzle: puzzle) } ) {
                    Text("Create New Puzzle").bold()
                }
                .buttonStyle(.borderedProminent)
                .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            .toolbar {
                //MARK: Display all possible numbers
                NavigationLink {
                    HelpView()
                } label: {
                    VStack {
                        Text(Image(systemName: "questionmark.circle"))
                        Text("Help")
                            .font(.footnote)
                    }
                }
            }
            
            .toolbar {
                Menu {
                    Section("FILES:") {
                        Button(action: { readFile = LoadAndSaveFiles.readFile(fileName: puzzle.name) }) {
                            Label("Load a file", systemImage: "folder")
                        }
                        Button(action: { LoadAndSaveFiles.saveFile(fileName: puzzle.name, fileContents: puzzle.content) } ) {
                            Label("Save a file", systemImage: "doc")
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

