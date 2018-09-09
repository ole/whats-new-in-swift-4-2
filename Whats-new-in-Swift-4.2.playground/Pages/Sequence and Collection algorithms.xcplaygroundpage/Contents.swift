/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Sequence and Collection algorithms

 ## `allSatisfy`

 [SE-0207](https://github.com/apple/swift-evolution/blob/master/proposals/0207-containsOnly.md "Add an allSatisfy algorithm to Sequence") adds an `allSatisfy` algorithm to `Sequence`. `allSatisfy` returns `true` if and only if all elements in the sequence satisfy the given predicate. This function is often just called `all` in functional languages.

 `allSatisfy` nicely complements `contains(where:)`, which can be used to test if any element (or none) satisfies a predicate.
 */
let digits = 0...9

let areAllSmallerThanTen = digits.allSatisfy { $0 < 10 }
areAllSmallerThanTen

let areAllEven = digits.allSatisfy { $0 % 2 == 0 }
areAllEven

/*:
 ## `last(where:)`, `lastIndex(where:)`, and `lastIndex(of:)`

 [SE-0204](https://github.com/apple/swift-evolution/blob/master/proposals/0204-add-last-methods.md "Add last(where:) and lastIndex(where:) Methods") adds a `last(where:)` method to `Sequence`, and `lastIndex(where:)` and `lastIndex(of:)` methods to `Collection`.
 */
let lastEvenDigit = digits.last { $0 % 2 == 0 }
lastEvenDigit

let text = "Vamos a la playa"

let lastWordBreak = text.lastIndex(where: { $0 == " " })
let lastWord = lastWordBreak.map { text[text.index(after: $0)...] }
lastWord

text.lastIndex(of: " ") == lastWordBreak

/*:
 ### Rename `index(of:)` and `index(where:)` to `firstIndex(of:)` and `firstIndex(where:)`

 For consistency, SE-0204 also renames `index(of:)` and `index(where:)` to `firstIndex(of:)` and `firstIndex(where:)`.

 */
let firstWordBreak = text.firstIndex(where: { $0 == " " })
let firstWord = firstWordBreak.map { text[..<$0] }
firstWord

/*:
 ## `removeAll(where:)`

 [SE-0197](https://github.com/apple/swift-evolution/blob/master/proposals/0197-remove-where.md "Adding in-place removeAll(where:) to the Standard Library") adds a `removeAll(where:)` method to `RangeReplaceableCollection`, allowing you to remove all elements from a collection that match the given predicate.

 It’s essentially a mutating variant of `filter` with an inverted predicate — `filter` _keeps_ elements that match the predicate, whereas `removeAll(where:)` _removes_ them.
 */

var numbers = Array(1...10)
numbers.removeAll(where: { $0 % 2 != 0 })
numbers

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
