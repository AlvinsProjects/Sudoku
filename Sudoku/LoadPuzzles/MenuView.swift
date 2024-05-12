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
    @State private var count = 0
    var word = ""
    @State private var selectedPuzzle = Puzzle(number: 0, name: "crme1", content: "")

    var body: some View {
        NavigationStack {
            Form() {
                Section(header: Text("SELECT THE PUZZLE TO LOAD OR SAVE")) {
                    //                List(dm.content) {
                    //                    Text("\($0.number).  \($0.name)")
                    //                }
                    
                    VStack {
                        Picker("Please choose a puzzle:", selection: $selectedPuzzle) {
                            ForEach(dm.content, id: \.self) {
                                Text("\($0.number).  \($0.name)")
                            }
                        }
                        Text("You selected:  \(selectedPuzzle.name)")
                            .bold()
                            .padding()
                    }
                }
                //            }
                
                Text(word)
                Text("FileName:  \(selectedPuzzle.name)").padding(.horizontal)
                
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
                    .navigationTitle("Menu Trial")
                
                Text("\n \(readFile)")
                    .padding(.horizontal)
                    .foregroundStyle(.green)
                
                Spacer()
                
            }
        }
    }
    
//    func loadFile() {
//        print("File Created")
////        ImportingExampleView()
//    }
    
    
//    func saveFile() {
//        print("File Saved")
//    }
    
//    func deleteFile() {
//        print("File Deleted")
//    }

}




#Preview {
    MenuView()
}

