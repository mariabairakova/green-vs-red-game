//position in 2D grid
struct Position {
    var x: Int = 0
    var y: Int = 0
}

//generic class representing 2D grid used in the game
class Grid<T> {

    var data: [[T]] = [] 
    var width: Int = 0
    var height: Int = 0

    init() { }

    init(width: Int, height: Int, defaultValue: T) {
        self.width = width
        self.height = height
        data = Array(repeating: Array(repeating: defaultValue, count: width), count: height) 
    }

    subscript(i: Int, j: Int ) -> T {
        get {
            data[i][j]
        }
        set(newValue) {
            data[i][j] = newValue
        }
    }

    //gets adjacent cells of specific cell by its position in the grid
    func getNeighbours(of cell: Position) -> [T] {
        
        let moveRow = [0, 0, 1, -1, -1, -1, 1, 1] 
        let moveColumn = [1, -1, 0, 0, -1, 1, -1, 1]
        var neighbours: [T] = []

        for i in 0...7 {
            let newX = cell.x + moveRow[i]
            let newY = cell.y + moveColumn[i]

            if validCoordinates(x: newX, y: newY) {
                neighbours.append(self[newX, newY])
            }
                      
        } 
        return neighbours
    }

    func validCoordinates(x: Int, y: Int) -> Bool {
        if x >= 0 && x < height && y >= 0 && y < width {
            return true
        }
        return false     
    }
   
}