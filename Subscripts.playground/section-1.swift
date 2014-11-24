// Boilerplate code

enum Direction {
    case North, South, East, West
}

class Place {
    var exits: Dictionary<Direction, Place> = []
}

let garden = Place()
let field = Place()

// Subscript

extension Place {
    subscript(direction: Direction) -> Place? {
        get {
            return exits[direction]
        }
        set(destination) {
            exits[direction] = destination
        }
    }
}

// Usage

// 1. long form
garden.exits[.South] = field
field.exits[.North] = garden

// 2. compact form (using the subscript)
garden[.South] = field
field[.North] = garden