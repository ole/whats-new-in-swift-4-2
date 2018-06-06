/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Conditional conformance enhancements

 ## Dynamic casts

 Conditional protocol conformances ([SE-0143](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md "Conditional conformances")) were the headline feature of Swift 4.1. The final piece of the proposal, runtime querying of conditional conformances, has landed in Swift 4.2. This means a dynamic cast to a protocol type (using `is` or `as?`), where the value conditionally conforms to the protocol, will now succeed when the conditional requirements are met.

 Example:
 */
func isEncodable(_ value: Any) -> Bool {
    return value is Encodable
}

// This would return false in Swift 4.1
let encodableArray = [1, 2, 3]
isEncodable(encodableArray)

// Verify that the dynamic check doesn't succeed when the conditional conformance criteria aren't met.
struct NonEncodable {}
let nonEncodableArray = [NonEncodable(), NonEncodable()]
assert(isEncodable(nonEncodableArray) == false)

/*:
 ## Synthesized conformances in extensions

 A small but important improvement to compiler synthesized protocol conformances, such as the automatic `Equatable` and `Hashable` conformances introduced in [SE-0185](https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md "Synthesizing Equatable and Hashable conformance").

 Protocol conformances can now be synthesized in extensions and not only on the type definition (the extension must still be in the same file as the type definition). This is more than a cosmetic change because it allows automatic synthesis of conditional conformances to `Equatable`, `Hashable`, `Encodable`, and `Decodable`.

 This example is from the [What’s New in Swift session at WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/401/). We can conditionally conform `Either` to `Equatable` and `Hashable`:
 */
enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

// No code necessary
extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Hashable where Left: Hashable, Right: Hashable {}

Either<Int, String>.left(42) == Either<Int, String>.left(42)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
