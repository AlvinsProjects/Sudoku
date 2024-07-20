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
        Puzzle(number: 12, name: "BruteForceEmpty", content: "000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
        Puzzle(number: 13, name: "UKFinal2006", content: "000020070400018005073000009000000700000080010000009003090005000800601030002000400")
    ]
}
 
    
    
struct LoadAndSaveFiles {
    
    //MARK: Save Puzzle Files to disc - as String
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
