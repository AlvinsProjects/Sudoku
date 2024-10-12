//
//  LoadAndSaveFiles.swift
//  TrialMenuApp
//
//  Created by Alvin Alleyne on 5/10/24.
//


import Foundation


struct Puzzle: Identifiable, Hashable {
    let id = UUID()
    var number: Int
    var name: String
    var content : String
}


struct puzArray {
    
    static var SudokuFiles = [
        Puzzle(number: 0, name: "CRME1", content: "400280010609430500070050040300840000097103480000092006080010070002079804050028001"),//CRME
        Puzzle(number: 1, name: "CRME2", content: "034000090600008214001027000409083050560000087020560401000210800857900006090000340"),
        Puzzle(number: 2, name: "CRME3", content: "005400180146080500070013000451008706080000010603700948000390070004070269019006400"),//easy
        Puzzle(number: 3, name: "Chap4Eg1", content: "409856700007402680508007004705060000604203500380070006056941000900028050200000008"),//LoneR
        Puzzle(number: 4, name: "Chap4Eg2", content: "080000109640001037070830000701003040005000083400605000900062008010009000024708500"),
        Puzzle(number: 5, name: "Easy", content: "004020081000450790620801000705002100090105070008700503000908037063047000840010900"), //tests
        Puzzle(number: 6, name: "Medium", content: "300084050000960807060000030236800700700000008009002361040000020903056000010490003"),
        Puzzle(number: 7, name: "Difficult", content: "000010300004607090180009007200406500010000040009501002400900013050208400008060000"),
        Puzzle(number: 8, name: "Extreme", content: "000008009050090000009004800002140003006000900400067100005900300000030070800400000"),
        Puzzle(number: 9, name: "BruteForce", content: "006074120002081460194263875629305700057006390301790650913657200005000936268439517"),
        Puzzle(number: 10, name: "bfTest1", content:  "004000000000800140800004000003000000060008300100360020096000458000090200700003906"),
        Puzzle(number: 11, name: "bfTest2", content: "400009005090000324050043108040302000000100546080000002360020007017000003500036081"),
        Puzzle(number: 12, name: "BruteFEmpty", content: "000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
        Puzzle(number: 13, name: "UKFinal2006", content: "000020070400018005073000009000000700000080010000009003090005000800601030002000400"),
        Puzzle(number: 14, name: "FaceBook", content: "700000000350000000289000000892500000435720000176938000517382900648195320923674518"),
        Puzzle(number: 15, name: "In/Out", content: "409701003005400200060503040078614900000958400954372186013840020042100308890235014"),
        Puzzle(number: 16, name: "Fig7-1", content: "921004570705209840084570209279400085546000700813705400402009708197608304058940007"),
        
        Puzzle(number: 17, name: "Outpu4", content: "........5.2...9....9..2...373..481.....36....58....4...1...358...42.......978...2"), // 1.4
        Puzzle(number: 18, name: "Outpu7", content: "..346..2..58.2...1.2.9...8...1....9.2..783.........3....9..6..........56.6..7.21."), // 0.0
        Puzzle(number: 19, name: "Outpu8", content: "38.1.........5.6.....9....3.4.........5.18.......9.561.6..2478.8.......6..4.8..2."), // 3.7
        Puzzle(number: 20, name: "Outpu9", content: ".......2...75...9.6....4........7....25.961..9......83...6..85.....1.....4.32..7."), // 0.0
        Puzzle(number: 21, name: "Outp10", content: ".75.....34......1....672.....9..16.....3....5.2.56...49.7.4......38.9............"),  // 1.5
        
        Puzzle(number: 22, name: "L0 Puzzle 01", content: "001368500000090000080050090800040009743619285100020004050070020000080000008436700"),
        Puzzle(number: 23, name: "L0 Puzzle 02", content: "700030002090070030000516000600050009574291386100040007000724000010080040300060008"),
        Puzzle(number: 24, name: "L0 Puzzle 03", content: "000279000900010008007040600050090030246153879010080040001020900800060002000931000"),
        Puzzle(number: 25, name: "L0 Puzzle 04", content: "200070004070291030000060000006010400981743265005080300000020000050937010600050008"),
        Puzzle(number: 26, name: "L0 Puzzle 05", content: "400030008000654000050090030008010400596742381002060900060020050000485000200070009"),
        Puzzle(number: 27, name: "L0 Puzzle 06", content: "060894030003060700000030000090020080642587391050010040000050000004070600070348020"),
        Puzzle(number: 28, name: "L0 Puzzle 07", content: "000653000400080003005010200600020001392761485800090002008070300100030004000945000"),
        Puzzle(number: 29, name: "L0 Puzzle 08", content: "000672000002090500010050020500010009721369854900080002050040010006020300000538000"),
        Puzzle(number: 30, name: "L0 Puzzle 09", content: "000492000003080500080060040100020003642358719300040005020030070006010300000974000"),
        Puzzle(number: 31, name: "L0 Puzzle 10", content: "004060700900020005000174000400050006698413527500090003000542000800030001005080200"),
        
        Puzzle(number: 32, name: "L1 Puzzle 11", content: "050070080600010004000298000090040050465729831070080040000137000300060009040050070"),
        Puzzle(number: 33, name: "L1 Puzzle 12", content: "900050006000489000080060050010090070234178695090020030050040010000217000700030009"),
        Puzzle(number: 34, name: "L1 Puzzle 13", content: "000694000800070003010050020009040800745318269008060700070080010500020004000136000"),
        Puzzle(number: 35, name: "L1 Puzzle 14", content: "000291000040050090500030007600070005427569813800040006100080009030010040000624000"),
        Puzzle(number: 36, name: "L1 Puzzle 15", content: "000080000005319400010020060900030001531967824800040006050090030002153900000070000"),
        Puzzle(number: 37, name: "L1 Puzzle 16", content: "700090002030010060000673000003020500614385927009040300000462000040030050300050001"),
        Puzzle(number: 38, name: "L1 Puzzle 17", content: "700080006000125000040070020200030001435617982900040005060090070000862000300050008"),
        Puzzle(number: 39, name: "L1 Puzzle 18", content: "000412000400050008006030100070060050654389217090070040003090700700040001000721000"),
        Puzzle(number: 40, name: "L1 Puzzle 19", content: "700090006000217000001040500004080300982731465003050100007060900000123000800070002"),
        Puzzle(number: 41, name: "L1 Puzzle 20", content: "005020800030040090000639000100090002598263714400070008000486000050010080007050600"),
        
        Puzzle(number: 42, name: "L2 Puzzle 21", content: "800417006000090000200060008009050400457986321003070600700020005000040000500639002"),
        Puzzle(number: 43, name: "L2 Puzzle 22", content: "060040050005982600000070000800090001239514876100020005000060000007231400040050020"),
        Puzzle(number: 44, name: "L2 Puzzle 23", content: "000862000000090000709040605005080200284516973006030800302050107000020000000671000"),
        Puzzle(number: 45, name: "L2 Puzzle 24", content: "000070000700986001030010050060020040452397816080050070070065030800139005000040000"),
        Puzzle(number: 46, name: "L2 Puzzle 25", content: "300050002080436090000010000800060003619382754500040009000020000040578020200090005"),
        Puzzle(number: 47, name: "L2 Puzzle 26", content: "000368000004020100900070005001030400835146927002050300100080002006010500000597000"),
        Puzzle(number: 48, name: "L2 Puzzle 27", content: "200070009000060000003829500005010200934256781002080900006741800000030000100090005"),
        Puzzle(number: 49, name: "L2 Puzzle 28", content: "004070800010030090000986000040020010625314978030050040000763000080040050002090100"),
        Puzzle(number: 50, name: "L2 Puzzle 29", content: "005149300000080000090030010900050008514827963600090007030060020000010000009573400"),
        
        Puzzle(number: 51, name: "L3 Puzzle 30", content: "000475000004030200030090040006080700817946325003050400040010050001020900000864000"),
        Puzzle(number: 52, name: "L3 Puzzle 31", content: "050812040000030000020040070001050300439738561002060400040080090000070000060194050"),
        Puzzle(number: 53, name: "L3 Puzzle 32", content: "200010007010675090007080300000040000843291675000050000008060700050824030100030004"),
        Puzzle(number: 54, name: "L3 Puzzle 33", content: "300080004020060010000195000002070500845623179009050200000836000090010030700040001"),
        Puzzle(number: 55, name: "L3 Puzzle 34", content: "003060500070853090000020000900070006267581349300040008000010000040695030008030600"),
        Puzzle(number: 56, name: "L3 Puzzle 35", content: "807010605000782000000060000080030050961845237050020010000090000000271000302050801"),
        Puzzle(number: 57, name: "L3 Puzzle 36", content: "000768000100020008060090040007040900586917234002030800030070080600050007000384000"),
        Puzzle(number: 58, name: "L3 Puzzle 37", content: "000138000000050000350070096080060070167923458090090030610090083000040000000815000"),
        Puzzle(number: 59, name: "L3 Puzzle 38", content: "010040080000020000020531060600070008139864527700050003060483010000010000080090050"),
        Puzzle(number: 60, name: "L3 Puzzle 39", content: "800356004050020070000080000500010009691734582400060007000040000010090030300671005"),
        Puzzle(number: 61, name: "L3 Puzzle 40", content: "070020060000978000900010003009080200316254798002060400800040009000537000030090040"),
    ]
}
 
    
    
struct LoadAndSaveFiles {
    
    //MARK: Save Puzzle Files to disc - as String14
    /// Save Puzzle Files to disc - as String
    /// - Parameters:
    ///   - fileName:     File name
    ///   - fileContents: Contents of the file
    static func saveFile(fileName: String, fileContents: String) {
        let directoryURL = getDocumentsDirectory().appendingPathComponent(fileName)
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("txt")
        // Create the data to be saved
        guard let data = fileContents.data(using: .utf8) else {
            print("Unable to convert string to data")
            return
        }
        // Save the data
        do {
            try data.write(to: fileURL)
            print("File saved: \(fileURL.absoluteURL)")
            // Catch any errors
        } catch {
            print("Unable to Save File:  \(error.localizedDescription)")
        }
    }
    

    
    //MARK: Read the Puzzle data from file on disc
    /// Read the puzzle data files from disk.
    /// - Parameter fileName: fileName
    /// - Returns:            Puzzle data as a string
    static func readFile(fileName: String) -> String {
        let directoryURL = getDocumentsDirectory().appendingPathComponent(fileName)
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("txt")
        print(directoryURL)
        var savedString1 = ""
        // Get the saved data
        do {
            let savedData = try Data(contentsOf: fileURL)
            // Convert the data back into a string
            if let savedString = String(data: savedData, encoding: .utf8) {
                savedString1 = savedString
            }
        } catch {
            print("Unable to read the file \(fileName).  \(error.localizedDescription)")
        }
        return savedString1
    }
    
    
    /// Function to get the sandbox URL that will be used for all save and reads
    /// - Returns: URL
    static func getDocumentsDirectory() -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return directoryURL[0]
    }
    
}
