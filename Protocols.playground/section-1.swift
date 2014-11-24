// Special Protocols
//
// LogicValue                       if logicValue {
// Printable                        "\(printable)"
// Sequence                         for x in sequence
// IntegerLiteralConvertible        65536
// FloatLiteralConvertible          1.0
// StringLiteralConvertible         "abc"
// ArrayLiteralConvertible          [ a, b, c ]
// DictionaryLiteralConvertible     [ a: x, b: y]
//

// Basic Protocol

protocol Pullable {
    func pull()
}

class Object: Pullable {
    func pull() {}
}