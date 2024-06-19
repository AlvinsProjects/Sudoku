//
//  HelpView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 6/16/24.
//

import SwiftUI

struct HelpView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [.centerColor, .outerColor]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 500)
                .ignoresSafeArea()
                ScrollView{
                    LazyVStack(alignment: .leading, spacing: 15) {
                        Text("\nThe files (puzzles) listed in the Picker are the puzzles presented in the \"Programming SUDOKU\" book by Wei-Ming Lee.\n\nCRME are puzzles solved by Column, Row, and Minigrid Elimination.\n\nThe remaining puzzles are listed by increasing difficulty - upto \"Brute Force\" methods.\n\nThe \"BruteForceEmpty\" puzzle is a blank puzzle that is solved by the computer and presented to the user.  BruteForce is the default setting and it generates random puzzles.  (The other selections allways produce the same solutions).\n\nIn order of difficulty, the computer solution methods are:\n1.  CRME\n2.  Lone Rangers\n3.  Twins\n4.  Triplets\n5.  Brute Force.")
                        
                        Text("Difficulty").bold()
                        Text("The difficulty of a puzzle is determined by the number of spaces there are on the grid.  The number displayed under \"Difficulty\" above the puzzle, is the number of cells that are blank for the selected difficulty.")
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Help/Explanation")
            .navigationBarTitleDisplayMode(.automatic)

        }
    }
}



#Preview {
    HelpView()
}
