//
//  StepsTakenView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/29/24.
//

import SwiftUI


struct StepsTakenView: View {
    
    @State private var steps = Globals.stepsTakenArray

    var body: some View {
        NavigationStack {
            
            List(steps) {
                Text("\($0.index).  \($0.steps)")
                    .font(.footnote)
            }
            .navigationTitle("Solution Steps")
        }
    }
}




#Preview {
    StepsTakenView()
}
