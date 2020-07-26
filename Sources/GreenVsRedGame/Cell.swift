//this class represents a cell in grid 

class Cell {

    var color: Color = .red 
    var currentState: State = .preservedColor

    init() {  }
    
    init(color: Color) {
        self.color = color
    }

    var changedOnCurrentTurn: Bool {
        get { currentState == .changedColor }
    }
}