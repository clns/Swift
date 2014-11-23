import Foundation

enum TrainStatus {
    case OnTime
    case Delayed(Int)
}
let trainStatus = TrainStatus.Delayed(1)

switch trainStatus {
case .OnTime:
    println("on time")
case .Delayed(1):
    println("nearly on time")
case .Delayed(2..<10):
    println("almost in time, under 10 minutes for sure")
case .Delayed(_):
    println("it'll get here when it's ready")
case .Delayed(let minutes): // simple pattern
    println("delayed by \(minutes) minutes")
}

// MARK: Enums as associated data of other enums

enum VacationStatus {
    case Travelling(TrainStatus)
    case Relaxing(daysLeft: Int)
}
let vacationStatus = VacationStatus.Travelling(trainStatus)

switch vacationStatus {
case .Travelling(.OnTime):
    println("Train's on time!")
case .Travelling(.Delayed(1...15)):
    println("Train is delayed with max. 15 mins")
case .Travelling(.Delayed(_)):
    println("OMG when will this train ride end")
default:
    println("other stuff")
}

// MARK: Ranges with the dynamic types of classes

class Car {}
class RaceCar: Car {}

func tuneUp(car: Car) {
    switch car {
    case let raceCar as RaceCar:
        println("It's a race car")
        fallthrough
    default:
        println("General tuneup")
    }
}

// MARK: Tuple patterns

let color = (1.0, 1.0, 1.0, 1.0)
switch color {
// each element of the tuple is an independent pattern
case (0.0, 0.5...1.0, let blue, _):
    println("Green and \(blue * 100)% blue")
// match multiple values and test additional conditions using a where clause
case let (r, g, b, 1.0) where r == g && g == b:
    println("Opaque grey \(r * 100)%")
default:
    println()
}

// MARK: Validating a Property List

func validPlist(list: Dictionary<String, AnyObject>) -> Bool {
    switch (list["name"], list["population"], list["abbr"]) {
    case (.Some(let listName as NSString),
        .Some(let pop as NSNumber),
        .Some(let abbr as NSString))
        where abbr.length == 2:
        return true;
    default:
        return false;
    }
}
validPlist(["name": "California", "population": 38_040_000, "abbr": "CA"])
validPlist(["name": "California", "population": "hella peeps", "abbr": "CA"])
validPlist(["name": "California", "population": 38_040_000, "abbr": "Cali"])