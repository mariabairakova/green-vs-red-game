//the class contains game logic

import Foundation

class Game {

    var grid: Grid<Cell> = Grid()

    //checks whether grid have changed 
    var repeatedState: Bool {
        get {
            for i in 0..<grid.height {
                for j in 0..<grid.width {
                    if grid[i, j].currentState == .changedColor {
                        return false
                    }
                }
            }
            return true
        }
    }
    
    init() { }

    //runs the game
    func run()   {

        var x, y, x1, y1, n: Int  

        do {
            (x, y) = try getGridSize() 
            try buildGenerationZero(width: x, height: y)
            (x1, y1, n) = try getCoordinatesAndN() 

            let greenOccurrences = calculate(x, y, x1, y1, n)
            print(greenOccurrences)          
           
        } catch {
            print(error)       
        }         
    }
}

//private functions 

extension Game {

    //reads first line of user input and returns tuple for grid's size, x - width, y - height  
    private func getGridSize() throws -> (Int, Int) {

        if let input = readLine() {

            let pattern = "^[0-9]+, [0-9]+$"
            if !matchesFormat(input, pattern) {
                throw SizeError.invalidFormat
            } 
 
            let size = input.filter{ $0 != " "}.split(separator: ",") //array with x and y values
            guard let x = Int(size[0]), let y = Int(size[1]) else {
                throw SizeError.invalidInput
            }

            if x <= y && x > 0 && y > 0 && x < 1000 && y < 1000 {
                return (x, y)
            } else {
                throw SizeError.invalidValues
            }
            
        } else {
            throw UserInputError.missingInput
        }
    }

    //gets the initial state of the grid 
    private func buildGenerationZero(width x: Int, height y: Int) throws {

        grid = Grid<Cell>(width: x, height: y, defaultValue: Cell())

        for i in 0..<y {

            var j = 0
            
            if let row = readLine() {
                if row.count == x { 
                    for char in row {
                        if let cellColor = Color(rawValue: char) { 
                            grid[i, j] = Cell(color: cellColor) //filling the grid 
                        } else {
                            throw GridParsingError.invalidSymbol
                        }
                        j+=1
                    }
                } else {
                    throw GridParsingError.invalidWidth
                }   
            } else {
                throw UserInputError.missingInput
            } 
            
        }
    }

    //reads coordinates of a cell to track and number of turns    
    private func getCoordinatesAndN() throws -> (Int, Int, Int) {
        
        if let input = readLine() {
            
            let pattern = "^[0-9]+, [0-9]+, [0-9]+$"
            if !matchesFormat(input, pattern) {
                throw CooordinatesAndNError.invalidFormat
            } 
 
            let size = input.filter{ $0 != " "}.split(separator: ",")  
            guard let y1 = Int(size[0]), let x1 = Int(size[1]), let n = Int(size[2]) else { //working with reversed x1 and y1 because of grid representation as 2D array
                throw CooordinatesAndNError.invalidInput
            }
            
            if grid.validCoordinates(x: x1, y: y1) {
                return (x1, y1, n)
            } else {
                throw CooordinatesAndNError.invalidValues
            }
        
        } else {
            throw UserInputError.missingInput
        } 
    }

    //checks whether user input is in specific format 
    private func matchesFormat(_ input: String, _ pattern: String) -> Bool {
 
        if let range = input.range(of: pattern, options: .regularExpression) {
            let validInput = input[range] //string with matched regular expression
            if validInput != input { //if user input contains something apart from matched expression
                return false
            }
        } else {
            return false
        }
        return true
    }

    //counts number of green cells adjacent to specific cell by its position in the grid
    private func getGreenNeighboursCount(of cell: Position) -> Int {

        var count = 0
        var neighbours: [Cell] = []
        neighbours = grid.getNeighbours(of: cell) //array with adjacent cells
        
        for neighbour in neighbours {
            if neighbour.color == .green && !neighbour.changedOnCurrentTurn {
                count += 1
            } 
            
            if neighbour.color == .red && neighbour.changedOnCurrentTurn {
                count += 1
            }
        }
        return count
    }

    //rules in which a red cell changes color
    private func applyRulesForRed(cell: Position) {

        let greenCells = getGreenNeighboursCount(of: cell)
    
        if greenCells == 3 || greenCells == 6 {        
            grid[cell.x, cell.y].color = .green
            grid[cell.x, cell.y].currentState = .changedColor
        } 

    }

    //rules in which a green cell changes color
    private func applyRulesForGreen(cell: Position) {

        let greenCells = getGreenNeighboursCount(of: cell)
    
        if !(greenCells == 2 || greenCells == 3 || greenCells == 6) {
            grid[cell.x, cell.y].color = .red
            grid[cell.x, cell.y].currentState = .changedColor
        } 
       
    }

    //applies rules for every cell in the grid
    private func changeGridState()  {
        for i in 0..<grid.height {
            for j in 0..<grid.width {
                if grid[i, j].color == .red {
                    applyRulesForRed(cell: Position(x: i, y: j))
                } else {
                    applyRulesForGreen(cell: Position(x: i, y: j))
                }
            }
        }
    }

    //resets every cell's current state
    private func resetGridState() {
        for i in 0..<grid.height {
            for j in 0..<grid.width {
                grid[i, j].currentState = .preservedColor
            }
        }
    }

    //returns in how many generations specific cell was green
    private func calculate(_ x: Int, _ y: Int, _ x1: Int, _ y1: Int, _ n: Int) -> Int {
        
        var count = 0

        //if the cell is green in generation zero
        if grid[x1, y1].color == .green {
                count = 1
        }

        //checking in next N generations of the grid
        for i in 0..<n {

            changeGridState() //generation i

            //stoping calculation when grid's cells have not changed their color since last generation
            if repeatedState {
                if grid[x1, y1].color == .green {
                    count += n - i 
                }
                return count
            } 

            if grid[x1, y1].color == .green {
                count += 1          
            }

            resetGridState() 
        }
        return count  
    }
}