//
//  HeaderView.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 6/17/24.
//

//import SwiftUI


//struct HeaderView: View {
//    
//    @State private var board = Board()
//    
//    var diff =  ""
//    var puzzIndex = 0
//    var puzzName = ""
//    var exTime = ""
//    var col = Color.black
//    var icon = ""
//
//    
//    var body: some View {
//        Grid {
//            Grid(alignment: .leading, horizontalSpacing: 30, verticalSpacing: 5) {
////                GridRow {
////                    Text("Puzzle Name:")
////                    Text("\(Globals.puzIndex).  \(puzzName)")
////                }
//                
//                GridRow {
//                    Text("Difficulty:")
//                    Text(diff)  // + " " + icon).foregroundStyle(col)
//                }
//                
//                GridRow {
//                    Text("Computer Solve Time:")
//                    Text("\(exTime)")
//                }
//                
//                GridRow {
//                    Text("Puzzle Solve Time:")
//                    TimerView()
//                }
//            }
//            .font(.footnote)
//            .padding(10)
//            .border(Color.secondary)
//        }
//    }
//
//}
//
//
//
//
//
//
//
//#Preview {
//    HeaderView(diff: "48, Medium", puzzName: "BruteForce", exTime: "0h, 0,m, 34s")
//        .preferredColorScheme(.dark)
//}
