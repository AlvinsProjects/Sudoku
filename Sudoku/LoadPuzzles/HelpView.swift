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
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 15) {
                    Text("\nThe files (puzzles) listed are the puzzles presented in the \"Programming SUDOKU\" book by Wei-Ming Lee.\n\nCRME are puzzles solved by Column, Row, and Minigrid elimination.\n\nThe remaining puzzles are listed by increasing difficulty - upto \"Brute Force\" methods.\n\nThe \"BruteForceEmpty\" puzzle is a blank puzzle that is solved by the computer and presented to the user.  BruteForce is the default setting and it generates random puzzles.  (The other selections produce te same solutions allways).\n\nIn order of difficulty, the computer solution methods are:\n\n1.  CRME\n2.  Lone Rangers\n3.  Twins\n4.  Triplets\n5.  Brute Force.")
                }
            }
            .padding()
            .border(.primary)
            .padding(.horizontal, 5)
            .navigationTitle("Explanation")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}



#Preview {
    HelpView()
}
