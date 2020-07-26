//types of error that can occur 

enum UserInputError: Error {
    case missingInput
}

enum SizeError: Error {
    case invalidInput
    case invalidFormat
    case invalidValues
}

enum CooordinatesAndNError: Error {
    case invalidInput
    case invalidFormat
    case invalidValues
}

enum GridParsingError: Error {
    case invalidWidth
    case invalidSymbol
}


//adding user messages

extension UserInputError: CustomStringConvertible {
    var description: String {
        switch self {         
            case .missingInput:
                return "No input!"
        }
    }
}

extension SizeError: CustomStringConvertible {
    var description: String {
        switch self {
            case .invalidInput:
                return "Invalid size entered!"
            case .invalidFormat:
                return "Invalid format! Size of the grid should be in 'x, y' format."
            case .invalidValues: 
                return "Size of the grid should be: 0 < x <= y < 1 000."
        }
    }
}

extension CooordinatesAndNError: CustomStringConvertible {
    var description: String {
        switch self {
            case .invalidInput:
                return "Invalid coordinates and turns entered!"
            case .invalidFormat: 
                return "Invalid format! Coordinates of a cell and turns should be in 'x1, y1, N' format."
            case .invalidValues: 
                return "Invalid coordinates values!"
        }
    }
}

extension GridParsingError: CustomStringConvertible {
    var description: String {
        switch self {
            case .invalidWidth:
                return "The row should contain x (width of grid) symbols!"
            case .invalidSymbol:
                return "The row contains invalid symbol - only '1' and '0' allowed!"
        }
    }
}