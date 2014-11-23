// Initializers:
// - 2 types: designated and convenience
// - designated can only call up (super); convenience can only call across (other convenience or designated initializers of the same class)
// - lazy properties (only for var)
// - deinitializers

class Car {
    var speed: Double
    
    init(speed: Double) {
        self.speed = speed
    }
    
    deinit {
        // cleanup non-memory resources
    }
}

class RaceCar: Car {
    var hasTurbo: Bool
    
    init(speed: Double, turbo: Bool) {
        hasTurbo = turbo
        super.init(speed: speed)
    }
    
    convenience override init(speed: Double) {
        self.init(speed: speed, turbo: true)
    }
    
    convenience init() {
        self.init(speed: 200.0, turbo: true)
    }
}

class FormulaCar: Car {
    let weight = 1081
    lazy var backupCar = RaceCar(speed: 210) // lazy property
}

let car = RaceCar()
let formulaOne = FormulaCar(speed: 300) // .backupCar is nil
formulaOne.backupCar
formulaOne  // .backupCar is initialized
