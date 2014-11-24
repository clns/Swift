// Protocol Types vs Generics
//
// Protocol types like Any *throw away* type information
// ∙ Great for Dynamic Polymorphism
//
// Swift Generics *conserve* type information
// ∙ Great for type safety
// ∙ Great for performance

func peek<T>(value: T) -> T {
    println("[peek] \(value)")
    return value;
}

peek("A string")
peek(123)

// Generic Stack

struct Stack<T> {
    var items: [T] = []
    
    mutating func push(x: T) {
        items.append(x)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var intStack = Stack<Int>()
intStack.push(42)

// Correct "Type 'Stack<T>' does not conform to protocol 'SequenceType'"
// Be able to do for...in on Stack<T>

extension Stack: SequenceType {
    func generate() -> StackGenerator<T> {
        return StackGenerator(items: items[0..<items.count])
    }
}

struct StackGenerator<T>: GeneratorType {
    typealias Element = T
    mutating func next() -> T? {
        if items.isEmpty { return nil }
        let ret = items[0]
        items = items[1..<items.count]
        return ret
    }
    
    var items: Slice<T>
}

func peekStack<T>(s: Stack<T>) {
    for x in s { println(x) }
}

peekStack(intStack)