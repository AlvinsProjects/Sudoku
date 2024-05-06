//
//  Globals.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 3/27/24.
//


import Foundation


struct Globals {
    
   
    //---used to store the state of the grid---
    static var actual = Array(Array(repeating: Array(repeating: 0, count: 9), count: 9))
    static var possible = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    
    static var bruteForceStop = false
    
    static var actualStack = [[[Int]]]()
    static var possibleStack = [[[String]]]()
    
    static var totalScore = 0
    static var actualBackup = [[Int]]()
    static var exTime = ""
    static var GlobePlayers = Array(Array(repeating: Array(repeating: "", count: 9), count: 9))
    static var diff = ""

    
    
    // CRME (Column, Row, MiniGrid Elimination) puzzles
    static let crme1 = "400280010609430500070050040300840000097103480000092006080010070002079804050028001"
    static let crme2 = "034000090600008214001027000409083050560000087020560401000210800857900006090000340"
    static let crme3 = "005400180146080500070013000451008706080000010603700948000390070004070269019006400"
    
    // Lone Rangers
    static let Chap4Eg1 = "409856700007402680508007004705060000604203500380070006056941000900028050200000008" // Chap4-Eg1
    static let Chap4Eg2 = "080000109640001037070830000701003040005000083400605000900062008010009000024708500" //Chap4-Eg2
    
    //Test Puzzles
    static let easy = "004020081000450790620801000705002100090105070008700503000908037063047000840010900"
    static let medium = "300084050000960807060000030236800700700000008009002361040000020903056000010490003"
    static let difficult = "000010300004607090180009007200406500010000040009501002400900013050208400008060000"
    static let extreme = "000008009050090000009004800002140003006000900400067100005900300000030070800400000"
    
    static let bruteForce = "006074120002081460194263875629305700057006390301790650913657200005000936268439517"
    static let bfTest1 = "004000000000800140800004000003000000060008300100360020096000458000090200700003906"
    static let bfTest2 = "400009005090000324050043108040302000000100546080000002360020007017000003500036081"
    static let bfEmpty = "000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    
    static var stepsTakenArray = [StepsTaken]()
    static var stepsCount = 0
}
    

struct StepsTaken: Identifiable {
    let id = UUID()
    var index: Int
    let steps: String
}
