/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # `@inlinable`

 [SE-0193](https://github.com/apple/swift-evolution/blob/master/proposals/0193-cross-module-inlining-and-specialization.md "Cross-module inlining and specialization") introduces two new attributes, `@inlinable` and `@usableFromInline`.

 These aren’t necessary for application code. Library authors can annotate some public functions as `@inlinable`. This gives the compiler the option to optimize generic code across module boundaries.

 For example, a library that provides a set of collection algorithms could mark those methods as `@inlinable` to allow the compiler to specialize client code that uses these algorithms with types that are unknown when the library is built.

 Example (adopted from the example given in SE-0193):
 */
// Inside CollectionAlgorithms module:
extension Sequence where Element: Equatable {
    /// Returns `true` iff all elements in the sequence are equal.
    @inlinable
    public func allEqual() -> Bool {
        var iterator = makeIterator()
        guard let first = iterator.next() else {
            return true
        }
        while let next = iterator.next() {
            if first != next {
                return false
            }
        }
        return true
    }
}

[1,1,1,1,1].allEqual()
Array(repeating: 42, count: 1000).allEqual()
[1,1,2,1,1].allEqual()

/*:
 Think carefully before you make a function inlinable. Using `@inlinable` effectively makes the body of the function part of your library’s public interface. If you later change the implementation (e.g. to fix a bug), binaries compiled against the old version might continue to use the old (inlined) code, or even a mix of old and new (because `@inlinable` is only a hint; the optimizer decides for each call site whether to inline the code or not).

 Because inlinable functions can be emitted into the client binary, they are not allowed to reference declarations that are not visible to the client binary. You can use the `@usableFromInline` annotation to make certain internal declarations in your library “ABI-public”, allowing their use in inlinable functions.
 */
/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
