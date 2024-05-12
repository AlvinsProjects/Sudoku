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
            
            if steps.isEmpty {
                List {
                    Text("There were no solution steps available!")
                        .bold()
                        .foregroundStyle(.red)
                }
            }
            
            List(steps) {
                Text("\($0.index).  \($0.steps)")
                    .font(.footnote).bold()
                    .foregroundStyle($0.steps.contains("Brute") ? .pink : .cyan)
            }
            .navigationTitle("Solution Steps")
        }
    }
}





#Preview {
    StepsTakenView()
}
