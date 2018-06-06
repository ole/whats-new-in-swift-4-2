/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Random numbers

 Working with random numbers used to be a little painful in Swift because (a) you had to call C APIs directly and (b) there wasn’t a good cross-platform random number API.

 [SE-0202](https://github.com/apple/swift-evolution/blob/master/proposals/0202-random-unification.md "Random Unification") adds random number generation to the standard library.

 ## Generating random numbers

 All number types have a `random(in:)` method that returns a random number in the given range (with a uniform distribution by default):
 */
Int.random(in: 1...1000)
UInt8.random(in: .min ... .max)
Double.random(in: 0..<1)

/*:
This API nicely protects you from a common error when generating random numbers, [modulo bias](https://www.quora.com/What-is-modulo-bias).

 `Bool.random` is also a thing:
 */
func coinToss(count tossCount: Int) -> (heads: Int, tails: Int) {
    var result = (heads: 0, tails: 0)
    for _ in 0..<tossCount {
        let toss = Bool.random()
        if toss {
            result.heads += 1
        } else {
            result.tails += 1
        }
    }
    return result
}

let (heads, tails) = coinToss(count: 100)
print("100 coin tosses — heads: \(heads), tails: \(tails)")

/*:
 ## Random collection elements

 Collections get a `randomElement` method (which returns an optional in case the collection is empty, like `min` and `max`):
 */
let emotions = "😀😂😊😍🤪😎😩😭😡"
let randomEmotion = emotions.randomElement()!

/*:
 Use the `shuffled` method to shuffle a collection:
 */
let numbers = 1...10
let shuffled = numbers.shuffled()

/*:
 ## Custom random number generators

 The standard library ships with a default random number generator, `Random.default`, that is probably a good choice for most simple use cases.

 If you have special requirements, you can implement your own random number generator by adopting the `RandomNumberGenerator` protocol. All APIs for generating random values provide an overload that allows users to pass in their preferred random number generator:
 */
/// A dummy random number generator that just mimics `Random.default`.
struct MyRandomNumberGenerator: RandomNumberGenerator {
    var base = Random.default
    mutating func next() -> UInt64 {
        return base.next()
    }
}

var badRNG = MyRandomNumberGenerator()
let notRandomAtAll = Int.random(in: 0...100, using: &badRNG)

/*:
 ## Extending your own types

 You can provide a random data API for your own types by following the same pattern:
 */
enum Suit: String, CaseIterable {
    case diamonds = "♦"
    case clubs = "♣"
    case hearts = "♥"
    case spades = "♠"

    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Suit {
        // Using CaseIterable for the implementation
        return allCases.randomElement(using: &generator)!

    }

    static func random() -> Suit {
        return Suit.random(using: &Random.default)
    }
}

let randomSuit = Suit.random()
randomSuit.rawValue

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
