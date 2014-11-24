// Boilerplate code

class Thing: Printable {
    var name = "Thing"
    var description: String {
        return name
    }
    var nameWithArticle: String {
        return "a " + name
    }
}

// New operator

infix operator ~ {} // define a new infix/binary operator
func ~(decorator: (Thing -> String), object: Thing) -> String {
    return decorator(object)
}
func an(object: Thing) -> String {
    return object.nameWithArticle
}

// Usage

let object = Thing()
println("You aren't sure how to pull \(an ~ object)")