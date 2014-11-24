// Automatic Memoization

func memoize<T: Hashable, U>(closure: ((T)->U, T)->U) -> (T)->U {
    var memo = Dictionary<T, U>()
    var result: ((T)->U)!
    result = {x in
        if let q = memo[x] { return q }
        let r = closure(result, x)
        memo[x] = r
        return r
    }
    return result
}

// Usage

func fibonacci(n: Int) -> Double {
    return n < 2 ? Double(n) : fibonacci(n-1) + fibonacci(n-2)
}
let phi = fibonacci(5) / fibonacci(4)

let fibonacci2:(Int -> Double) = memoize {
    fibonacci2, n in
    return n < 2 ? Double(n) : fibonacci2(n-1) + fibonacci2(n-2)
}
let phi2 = fibonacci2(5) / fibonacci2(4)