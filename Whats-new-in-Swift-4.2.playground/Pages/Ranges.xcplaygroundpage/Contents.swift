/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Removal of `CountableRange` and `CountableClosedRange`

 The introduction of conditional protocol conformances ([SE-0143](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md "Conditional conformances")) in Swift 4.1 allowed the standard library to eliminate a ton of types that were formerly required but whose functionality can now be expressed as constrained extensions on a base type.

 For example, the functionality of `MutableSlice<Base>` is now incporporated by a “normal” `Slice<Base>`, together with an `extension Slice: MutableCollection where Base: MutableCollection`.

 Swift 4.2 introduces a similar consolidation for ranges. The formerly concrete types `CountableRange` and `CountableClosedRange` have been removed in favor of conditional conformances for `Range` and `ClosedRange`.

 The purpose of the countable range types was to allow a range to be a `Collection` if its underlying element type was _countable_ (i.e., it conformed to the `Strideable` protocol and used signed integers for striding). For example, range of integers can be collections, but ranges of floating-point numbers can't
 */

let integerRange: Range = 0..<5
// We can map over a range of integers because it's a Collection
let integerStrings = integerRange.map { String($0) }
integerStrings

let floatRange: Range = 0.0..<5.0
// But this is an error because a range of Doubles is not a Collection
//floatRange.map { String($0) } // error!

/*:
 The names `CountableRange` and `CountableClosedRange` still exist; they have been converted to typealiases for source compatibility. You shouldn’t use them in new code anymore.

 The distinction between half-open `Range` and closed ranges `ClosedRange` still exists on the type system level because it cannot be eliminated so easily. A `ClosedRange` can never be empty and a `Range` can never contain the maximum value of its element type (e.g. `Int.max`). Moreover, the difference is important for non-countable types: it’s not trivial to rewrite a range like `0.0...5.0` into an equivalent half-open range.
 */
/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
