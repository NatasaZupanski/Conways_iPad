//
//  File.swift
//  Conways_iPad (iOS)
//
//  Created by Clara Dutton on 4/9/21.
//

//
//  Colony.swift
//  TestingGitHub (iOS)
//
//  Created by Natasa Zupanski on 4/23/21.
//



import Foundation

struct Colony : CustomStringConvertible , Identifiable, Codable {//, ObservableObject {
//    private (set) var name: String
    //private (set) var generationNumber = 0
    var id = UUID()
    var name: String
    var generationNumber = 0
    var locked = false
    var originalTemplate = "Blank"//: String

    ///Length of edge of square colony
    private var size:Int;
    var wrap = false

    ///A set of all alive cells.
    //private var aliveCells:Set<Coordinate>;
    var aliveCells: [Coordinate]
    ///Reference for evolve()
//    private var refSet:Set<Coordinate>;

    init(size: Int = 60, name: String = "Unnamed Colony", originalTemplate: String = "Blank") {
        self.size = size;
        self.aliveCells = [];
        self.name = name;
        self.originalTemplate = originalTemplate
    }

    /*mutating func setColonyFromCoors(cells: [Coordinate]) {
        aliveCells = Set(cells)
    }*/

//    mutating func setName(name: String) {
//
//    }
    
    func withinBounds(row: Int, col: Int) -> Bool {
        if row >= 0 && row <= 59 && col >= 0 && col <= 59 {
            return true
        }
        return false
    }

    ///deletes all alive cells in colony
    mutating func clear() {
        aliveCells = [];
    }

    ///Sets a cell to be alive
    /// If the cell is already alive, it will leave it alive.
    ///
    /// - Parameters:
    ///   - row: Row of cell to make alive
    ///   - col: Column of cell to make alive
    mutating func setCellAlive(row:Int, col: Int) {
        if !isCellAlive(row: row, col: col) {
            //if !aliveCells.contains(Coordinate(row, col)) {
                //aliveCells.insert(Coordinate(row, col))
                //print("\(row), \(col): set Alive")
                aliveCells.append(Coordinate(row, col))
            //}
        }
    }

    ///Deletes a cell that is in the set of alive cells.
    /// If the cell is already dead, won't do anything.
    ///
    /// - Parameters:
    ///   - row: Row of cell to kill
    ///   - col: Column of cell to kill
    mutating func setCellDead(row:Int, col: Int) {
        
        //aliveCells.remove(Coordinate(row, col))
        if isCellAlive(row: row, col: col) {
            for index in 0..<(aliveCells.count) {
                if aliveCells[index].row == row && aliveCells[index].col == col {
                    //print("\(row), \(col) : set Dead")
                    aliveCells.remove(at: index)
                    return
                }
            }
        }
    }

    ///Returns if the given cell is alive.
    ///
    /// - Parameters:
    ///   - row: Row of cell to check
    ///   - col: Column of cell to check
    /// - Returns: true if cell alive, false if dead
    func isCellAlive(row: Int, col: Int) -> Bool {
        //if there is a Coordinate with the corresponding coordinates, there is an alive cell
        livingCells.contains(Coordinate(row, col))
//        for index in 0..<(aliveCells.count) {
//            if aliveCells[index].row == row && aliveCells[index].col == col {
//                //print("\(row), \(col): is Alive")
//                return true
//            }
//        }
//        return false
    }

    ///Gets all the living cells as an array
    ///
    /// - Returns: Array of Coordinates representing living cells
    var livingCells: Set<Coordinate> {
        Set(aliveCells)
    }
    
    var livingCells2 : [Coordinate] {
        get {
            return Array(aliveCells)
        }
        set(newCells) {
            clear()
            for cell in newCells {
                setCellAlive(row: cell.row, col: cell.col)
            }
        }
    }
    
    ///Counts the number of neighboring alive cells for the evolve() function
    ///Gets the row and column of a cell
    ///
    /// - Returns: the number of surrounding cells
    func countNeighbors(_ row: Int, _ col: Int, wrap: Bool) -> Int{
        var count = 0
        let index: [(r: Int, c: Int)] = [(row + 1, col + 1), (row + 1, col), (row + 1, col - 1), (row, col + 1), (row, col - 1), (row - 1, col + 1), (row - 1, col), (row - 1, col - 1)]
        
        for i in index{
            if wrap{
                //if aliveCells.contains(Coordinate(wrapCoors(i.r), wrapCoors(i.c))){count += 1}
                if isCellAlive(row: wrapCoors(i.r), col: wrapCoors(i.c)){count += 1}

            } else {
                //if aliveCells.contains(Coordinate(i.r, i.c)){count += 1}
                if isCellAlive(row: i.r, col: i.c){count += 1}
            }
        }
        return count
    }

    
    func setHelper(wrap: Bool = false) -> Set<Coordinate> {
        var result = livingCells
        for a in aliveCells {
            let index: [(r: Int, c: Int)] = [(a.row + 1, a.col + 1), (a.row + 1, a.col), (a.row + 1, a.col - 1), (a.row, a.col + 1), (a.row, a.col - 1), (a.row - 1, a.col + 1), (a.row - 1, a.col), (a.row - 1, a.col - 1)]
            for i in index{
                if wrap{
                    //result.insert(Coordinate(wrapCoors(i.r), wrapCoors(i.c)))
                    if !isCellAlive(row: wrapCoors(i.r), col: wrapCoors(i.c)) {
                        result.insert(Coordinate(wrapCoors(i.r), wrapCoors(i.c)))
                    }
                } else {
                    //result.insert(Coordinate(i.r, i.c))
                    if !isCellAlive(row: i.r, col: i.c) {
                         result.insert(Coordinate(i.r, i.c))
                    }
                }
            }
        }
        return result
    }
    
    ///Takes a Bool called wrap, which will wrap the values if true
    ///creates a new set, and adds all of the new alive cells to it, and then sets the alive cells set equal to this new set
    mutating func evolve() {
        var newGen = Set<Coordinate>()
        let set = setHelper(wrap: wrap)
        for a in set {
            switch countNeighbors(a.row, a.col, wrap: wrap){
                case 3: newGen.insert(Coordinate(a.row, a.col))
                case 2:
//                    if aliveCells.contains(Coordinate(a.row, a.col)) {
//                        newGen.insert(Coordinate(a.row, a.col))
//                    } else { break; }
                    if isCellAlive(row: a.row, col: a.col) {
                        newGen.insert(Coordinate(a.row, a.col))
                    } else { break; }
                default: break;
            }
        }
        //print("it evolved")
        //print(newGen)
        //if wrap {print("With wrap")}
        newGen = newGen.filter{withinBounds(row: $0.row, col: $0.col)}
        aliveCells = Array(newGen)
        generationNumber += 1
    }
    /*mutating func evolve() {
        var newGen = [Coordinate]()
        let set = setHelper(wrap: wrap)
        for a in set {
            switch countNeighbors(a.row, a.col, wrap: wrap){
                case 3: newGen.append(Coordinate(a.row, a.col))
                case 2:
                    /*if aliveCells.contains(Coordinate(a.row, a.col)) {
                        newGen.append(Coordinate(a.row, a.col))
                    } else { break; }*/
                    if isCellAlive(row: a.row, col: a.col) {
                        newGen.append(Coordinate(a.row, a.col))
                    } else { break; }
                default: break;
            }
        }
        print("it evolved \(generationNumber)")
        //print(newGen)
        //if wrap {print("With wrap")}
        newGen = newGen.filter{withinBounds(row: $0.row, col: $0.col)}
        aliveCells = newGen
        generationNumber += 1
    }*/
    
    ///Wraps the coordinates for the countNeighbors function as needed
    ///Gets the coordinate value (i.e. a row or a col)
    ///
    /// - Returns: the wrapped value
    func wrapCoors (_ c: Int) -> Int{
        var newCoors = c
        switch c {
            case size: newCoors = 0; break;
            case -1: newCoors = size - 1; break;
            default: break
        }
        
        return newCoors
    }
    
    ///calls the evolve function and sets wrap to true (thus wrapping the values)
    mutating func evolveWrap() {
        wrap = true
        evolve()
    }

    ///Number of alive cells in the colony
    var numberLivingCells:Int {
        aliveCells.count
    }

    ///Returns an 'image' of text of what the colony looks like
    var description: String {
        let aliveIcon : String = "*"
        let deadIcon : String = " "

        var retString = "Generation #\(generationNumber):\n"
        for row in 0..<size {
            for col in 0..<size {
                retString += (isCellAlive(row: row, col: col) ? aliveIcon : deadIcon)
                if col == size-1 {
                    retString += "\n"
                }
            }
        }
        return retString
    }
}
/*
struct Colony : CustomStringConvertible , Identifiable {//, ObservableObject {
//    private (set) var name: String
    //private (set) var generationNumber = 0
    let id = UUID()
    var name: String
    var generationNumber = 0
    var locked = false
    var originalTemplate: String

    ///Length of edge of square colony
    private var size:Int;
    var wrap = false

    ///A set of all alive cells.
    //private var aliveCells:Set<Coordinate>;
    var aliveCells: Set<Coordinate>
    ///Reference for evolve()
//    private var refSet:Set<Coordinate>;

    init(size: Int = 60, name: String = "Unnamed Colony", originalTemplate: String = "Blank") {
        self.size = size;
        aliveCells = [];
        self.name = name;
        self.originalTemplate = originalTemplate
    }

    mutating func setColonyFromCoors(cells: [Coordinate]) {
        aliveCells = Set(cells)
    }

//    mutating func setName(name: String) {
//
//    }

    ///deletes all alive cells in colony
    mutating func clear() {
        aliveCells = [];
    }
    
    func withinBounds(row: Int, col: Int) -> Bool {
        if row >= 0 && row <= 59 && col >= 0 && col <= 59 {
            return true
        }
        return false
    }

    ///Sets a cell to be alive
    /// If the cell is already alive, it will leave it alive.
    ///
    /// - Parameters:
    ///   - row: Row of cell to make alive
    ///   - col: Column of cell to make alive
    mutating func setCellAlive(row:Int, col: Int) {
        if !aliveCells.contains(Coordinate(row, col)) {
            aliveCells.insert(Coordinate(row, col))
        }
    }

    ///Deletes a cell that is in the set of alive cells.
    /// If the cell is already dead, won't do anything.
    ///
    /// - Parameters:
    ///   - row: Row of cell to kill
    ///   - col: Column of cell to kill
    mutating func setCellDead(row:Int, col: Int) {
        print("\(row), \(col) : set Dead")
        aliveCells.remove(Coordinate(row, col))
    }

    ///Returns if the given cell is alive.
    ///
    /// - Parameters:
    ///   - row: Row of cell to check
    ///   - col: Column of cell to check
    /// - Returns: true if cell alive, false if dead
    func isCellAlive(row: Int, col: Int) -> Bool {
        //if there is a Coordinate with the corresponding coordinates, there is an alive cell
        aliveCells.contains(Coordinate(row, col))
    }

    ///Gets all the living cells as an array
    ///
    /// - Returns: Array of Coordinates representing living cells
    var livingCells: [Coordinate] {
        return Array(aliveCells)
    }
    
    var livingCells2 : [Coordinate] {
        get {
            return Array(aliveCells)
        }
        set(newCells) {
            clear()
            for cell in newCells {
                setCellAlive(row: cell.row, col: cell.col)
            }
        }
    }
    
    ///Counts the number of neighboring alive cells for the evolve() function
    ///Gets the row and column of a cell
    ///
    /// - Returns: the number of surrounding cells
    func countNeighbors(_ row: Int, _ col: Int, wrap: Bool) -> Int{
        var count = 0
        let index: [(r: Int, c: Int)] = [(row + 1, col + 1), (row + 1, col), (row + 1, col - 1), (row, col + 1), (row, col - 1), (row - 1, col + 1), (row - 1, col), (row - 1, col - 1)]
        
        for i in index{
            if wrap{
                if aliveCells.contains(Coordinate(wrapCoors(i.r), wrapCoors(i.c))){count += 1}
            } else {
                if aliveCells.contains(Coordinate(i.r, i.c)){count += 1}
            }
        }
        return count
    }

    
    func setHelper(wrap: Bool = false) -> Set<Coordinate>{
        var result = aliveCells
        for a in aliveCells{
            let index: [(r: Int, c: Int)] = [(a.row + 1, a.col + 1), (a.row + 1, a.col), (a.row + 1, a.col - 1), (a.row, a.col + 1), (a.row, a.col - 1), (a.row - 1, a.col + 1), (a.row - 1, a.col), (a.row - 1, a.col - 1)]
            for i in index{
                if wrap{
                    result.insert(Coordinate(wrapCoors(i.r), wrapCoors(i.c)))
                } else {
                    result.insert(Coordinate(i.r, i.c))
                }
            }
        }
        return result
    }
    
    ///Takes a Bool called wrap, which will wrap the values if true
    ///creates a new set, and adds all of the new alive cells to it, and then sets the alive cells set equal to this new set
    mutating func evolve() {
        var newGen = Set<Coordinate>()
        let set = setHelper(wrap: wrap)
        for a in set {
            switch countNeighbors(a.row, a.col, wrap: wrap){
                case 3: newGen.insert(Coordinate(a.row, a.col))
                case 2:
//                    if aliveCells.contains(Coordinate(a.row, a.col)) {
//                        newGen.insert(Coordinate(a.row, a.col))
//                    } else { break; }
                    if isCellAlive(row: a.row, col: a.col) {
                        newGen.insert(Coordinate(a.row, a.col))
                    } else { break; }
                default: break;
            }
        }
        //print("it evolved")
        //print(newGen)
        //if wrap {print("With wrap")}
        newGen = newGen.filter{withinBounds(row: $0.row, col: $0.col)}
        aliveCells = newGen
        generationNumber += 1
    }
    
    ///Wraps the coordinates for the countNeighbors function as needed
    ///Gets the coordinate value (i.e. a row or a col)
    ///
    /// - Returns: the wrapped value
    func wrapCoors (_ c: Int) -> Int{
        var newCoors = c
        switch c {
            case size: newCoors = 0; break;
            case -1: newCoors = size - 1; break;
            default: break;
        }
        
        return newCoors
    }
    
    ///calls the evolve function and sets wrap to true (thus wrapping the values)
    mutating func evolveWrap() {
        wrap = true
        evolve()
    }

    ///Number of alive cells in the colony
    var numberLivingCells:Int {
        aliveCells.count
    }

    ///Returns an 'image' of text of what the colony looks like
    var description: String {
        let aliveIcon:String = "*"
        let deadIcon:String = " "

        var retString = "Generation #\(generationNumber):\n"
        for row in 0..<size {
            for col in 0..<size {
                retString += (isCellAlive(row: row, col: col) ? aliveIcon : deadIcon)
                if col == size-1 {
                    retString += "\n"
                }
            }
        }
        return retString
    }
}

/*class ColonyTimer : Identifiable {
    let id : UUID
    
    init(_ colony: Colony) {
        self.id = colony.id
    }
 }


/*import Foundation

struct Colony : CustomStringConvertible , Identifiable {//, ObservableObject {
//    private (set) var name: String
    //private (set) var generationNumber = 0
    let id = UUID()
    var name: String
    var generationNumber = 0
    var locked = false
    var originalTemplate: String

    ///Length of edge of square colony
    private var size:Int;
    var wrap = false

    ///A set of all alive cells.
    //private var aliveCells:Set<Coordinate>;
    var aliveCells: Set<Coordinate>
    ///Reference for evolve()
//    private var refSet:Set<Coordinate>;

    init(size: Int = 60, name: String = "Unnamed Colony", originalTemplate: String = "Blank") {
        self.size = size;
        aliveCells = [];
        self.name = name;
        self.originalTemplate = originalTemplate
    }

    mutating func setColonyFromCoors(cells: [Coordinate]) {
        aliveCells = Set(cells)
    }

//    mutating func setName(name: String) {
//
//    }

    ///deletes all alive cells in colony
    mutating func clear() {
        aliveCells = [];
    }

    ///Sets a cell to be alive
    /// If the cell is already alive, it will leave it alive.
    ///
    /// - Parameters:
    ///   - row: Row of cell to make alive
    ///   - col: Column of cell to make alive
    mutating func setCellAlive(row:Int, col: Int) {
        if !aliveCells.contains(Coordinate(row, col)) {
            aliveCells.insert(Coordinate(row, col))
        }
    }

    ///Deletes a cell that is in the set of alive cells.
    /// If the cell is already dead, won't do anything.
    ///
    /// - Parameters:
    ///   - row: Row of cell to kill
    ///   - col: Column of cell to kill
    mutating func setCellDead(row:Int, col: Int) {
        print("\(row), \(col) : set Dead")
        aliveCells.remove(Coordinate(row, col))
    }

    ///Returns if the given cell is alive.
    ///
    /// - Parameters:
    ///   - row: Row of cell to check
    ///   - col: Column of cell to check
    /// - Returns: true if cell alive, false if dead
    func isCellAlive(row: Int, col: Int) -> Bool {
        //if there is a Coordinate with the corresponding coordinates, there is an alive cell
        aliveCells.contains(Coordinate(row, col))
    }

    ///Gets all the living cells as an array
    ///
    /// - Returns: Array of Coordinates representing living cells
    func livingCells() -> [Coordinate] {
        Array(aliveCells)
    }
    
    ///Counts the number of neighboring alive cells for the evolve() function
    ///Gets the row and column of a cell
    ///
    /// - Returns: the number of surrounding cells
    func countNeighbors(_ row: Int, _ col: Int, wrap: Bool) -> Int{
        var count = 0
        let index: [(r: Int, c: Int)] = [(row + 1, col + 1), (row + 1, col), (row + 1, col - 1), (row, col + 1), (row, col - 1), (row - 1, col + 1), (row - 1, col), (row - 1, col - 1)]
        
        for i in index{
            if wrap{
                if aliveCells.contains(Coordinate(wrapCoors(i.r), wrapCoors(i.c))){count += 1}
            } else {
                if aliveCells.contains(Coordinate(i.r, i.c)){count += 1}
            }
        }
        return count
    }

    
    func setHelper(wrap: Bool = false) -> Set<Coordinate>{
        var result = aliveCells
        for a in aliveCells{
            let index: [(r: Int, c: Int)] = [(a.row + 1, a.col + 1), (a.row + 1, a.col), (a.row + 1, a.col - 1), (a.row, a.col + 1), (a.row, a.col - 1), (a.row - 1, a.col + 1), (a.row - 1, a.col), (a.row - 1, a.col - 1)]
            for i in index{
                if wrap{
                    result.insert(Coordinate(wrapCoors(i.r), wrapCoors(i.c)))
                } else {
                    result.insert(Coordinate(i.r, i.c))
                }
            }
        }
        return result
    }
    
    ///Takes a Bool called wrap, which will wrap the values if true
    ///creates a new set, and adds all of the new alive cells to it, and then sets the alive cells set equal to this new set
    mutating func evolve() {
        var newGen = Set<Coordinate>()
        let set = setHelper(wrap: wrap)
        for a in set {
            switch countNeighbors(a.row, a.col, wrap: wrap){
                case 3: newGen.insert(Coordinate(a.row, a.col))
                case 2:
                    if aliveCells.contains(Coordinate(a.row, a.col)) {
                        newGen.insert(Coordinate(a.row, a.col))
                    } else { break; }
                default: break;
            }
        }
        //print("it evolved")
        //print(newGen)
        //if wrap {print("With wrap")}
        aliveCells = newGen
        generationNumber += 1
    }
    
    ///Wraps the coordinates for the countNeighbors function as needed
    ///Gets the coordinate value (i.e. a row or a col)
    ///
    /// - Returns: the wrapped value
    func wrapCoors (_ c: Int) -> Int{
        var newCoors = c
        switch c {
            case size: newCoors = 0; break;
            case -1: newCoors = size - 1; break;
            default: break;
        }
        
        return newCoors
    }
    
    ///calls the evolve function and sets wrap to true (thus wrapping the values)
    mutating func evolveWrap() {
        wrap = true
        evolve()
    }

    ///Number of alive cells in the colony
    var numberLivingCells:Int {
        aliveCells.count
    }

    ///Returns an 'image' of text of what the colony looks like
    var description: String {
        let aliveIcon:String = "*"
        let deadIcon:String = " "

        var retString = "Generation #\(generationNumber):\n"
        for row in 0..<size {
            for col in 0..<size {
                retString += (isCellAlive(row: row, col: col) ? aliveIcon : deadIcon)
                if col == size-1 {
                    retString += "\n"
                }
            }
        }
        return retString
    }
 }*/*/*/
