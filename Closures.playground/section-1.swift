import Foundation // to use .uppercaseString

// Closure signature:
// {(<param>: <type>[, ...]) -> <return-type> in
//     // closure body
// }

var clients = ["Portland", "John", "Swiss", "Bangalu", "Colen"]

clients.sort({(a: String, b: String) -> Bool in
    return countElements(a) < countElements(b)
})

// type inference
clients.sort({a, b in
    return a < b
})

// if single return statement
// Interesting: if import Foundation, ">" doesn't work, says
// Ambiguous use of operator '>'. '<' works though!
clients.sort({a, b in
    a < b
})

// implicit argument names
clients.sort({$0 < $1})

// trailing closure syntax
clients.sort{return $0 > $1}

// other examples
let cls = clients.filter {$0.hasSuffix("n")}
.map {$0.uppercaseString}
cls

// function values
clients.map{
    println($0)
}
clients.map(println)

// prevent leaks (captures)
class TempNotifier {
    var onChange: (Int) -> Void = {_ in}
    var currentTemp = 72
    
    init() {
        onChange = {[unowned self] temp in // prevent strong ref for 'self'
            self.currentTemp = temp
        }
    }
}
let notifier = TempNotifier()
notifier.onChange(13)
notifier