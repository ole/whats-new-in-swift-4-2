/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # `Hashable` redesign

 Compiler-synthesized `Equatable` and `Hashable` conformances, introduced in Swift 4.1 ([SE-0185](https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md "Synthesizing Equatable and Hashable conformance")), dramatically reduce the number of manual `Hashable` implementations you have to write.

 But if you need to customize a type’s `Hashable` conformance, the redesign of the `Hashable` protocol ([SE-0206](https://github.com/apple/swift-evolution/blob/master/proposals/0206-hashable-enhancements.md "Hashable Enhancements")) makes this task much easier.

 In the new `Hashable` world, instead of implementing `hashValue`, you now implement the `hash(into:)` method. This method provides a `Hasher` object, and all you have to do in your implementation is feed it the values you want to include in your hash value by repeatedly calling `hasher.combine(_:)`.

 The advantage over the old way is that you don’t have to come up with your own algorithm for combining the hash values your type is composed of. The hash function provided by the standard library (in the form of `Hasher`) is almost certainly better and more secure than anything most of us would write.

 As an example, here is a type with one stored property that acts as a cache for an expensive computation. We should ignore the value of `distanceFromOrigin` in our `Equatable` and `Hashable` implementations:
 */
struct Point {
    var x: Int { didSet { recomputeDistance() } }
    var y: Int { didSet { recomputeDistance() } }

    /// Cached. Should be ignored by Equatable and Hashable.
    private(set) var distanceFromOrigin: Double

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        self.distanceFromOrigin = Point.distanceFromOrigin(x: x, y: y)
    }

    private mutating func recomputeDistance() {
        distanceFromOrigin = Point.distanceFromOrigin(x: x, y: y)
    }

    private static func distanceFromOrigin(x: Int, y: Int) -> Double {
        return Double(x * x + y * y).squareRoot()
    }
}

extension Point: Equatable {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        // Ignore distanceFromOrigin for determining equality
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

/*:
 In our `hash(into:)` implementation, all we need to do is feed the relevant properties to the hasher.

 This is easier (and more efficient) than coming up with your own hash combining function. For example, a naive implementation for `hashValue` might XOR the two coordinates: `return x ^ y`. This would be a less efficient hash function because `Point(3, 4)` and `Point(4, 3)` would end up with the same hash value.
 */
extension Point: Hashable {
    func hash(into hasher: inout Hasher) {
        // Ignore distanceFromOrigin for hashing
        hasher.combine(x)
        hasher.combine(y)
    }
}

let p1 = Point(x: 3, y: 4)
p1.hashValue
let p2 = Point(x: 4, y: 3)
p2.hashValue
assert(p1.hashValue != p2.hashValue)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
