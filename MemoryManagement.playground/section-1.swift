// References: strong (default), weak, unowned
//
// Weak References:
// - this object isn't responsible for keeping this object alive
// - are optional values
// - great for breaking cycles, but not always ideal
// - use them among objects with independent lifetimes
//
// Unowned References:
// - although I don't have an owning stack on the object my life depends on it, I cannot leave without my owner
// - you can use them just like strong references (assign in a local variable, call methods on it)
// - use them from owned objects with the same lifetime

class Person {
    weak var apartment: Apartment?   // weak reference
    var card: CreditCard?   // strong reference
    
    func moveIn(apartment: Apartment) {
        self.apartment = apartment
    }
    func saveCard(card: CreditCard) {
        self.card = card
    }
    func getCardNumber() -> Int? {
        return card?.number
    }
}

class Apartment {
    func buzzIn() {
        println("Buzzz")
    }
    func bye() {
        println("Bye!")
    }
}

class CreditCard {
    unowned let holder: Person  // unowned reference
    let number: Int
    init(holder: Person, number: Int) {
        self.holder = holder
        self.number = number
    }
}

var renters = ["John": Person()]
var apts = [0: Apartment()]

// MARK: test weak refs

renters["John"]!.moveIn(apts[0]!)
if let tenant = renters["John"]!.apartment { // binding produces strong ref
    println("John lives in an apartment")
} else {
    println("John doesn't live in an apartment")
}
renters["John"]!.apartment?.buzzIn()
renters["John"]!.apartment?.bye() // this is INCORRECT as buzzIn() may cause the object to get released, thus bye() will not be called

// MARK: test ounowned refs

renters["John"]!.saveCard(CreditCard(holder: renters["John"]!, number: 1234))
renters["John"]!.card?.holder.getCardNumber() // you can be sure the holder exists

// MARK: deallocate

renters["John"] = nil   // Person() and CreditCard() objects are deallocated
apts[0] = nil   // Apartment() object is deallocated

// MARK: prevent leaks with closure captures

class TempNotifier {
    var onChange: (Int) -> Void = {_ in}
    var currentTemp = 72
    
    init() {
        onChange = {[unowned self] temp in // prevent strong ref for 'self'
            self.currentTemp = temp
        }
    }
}
