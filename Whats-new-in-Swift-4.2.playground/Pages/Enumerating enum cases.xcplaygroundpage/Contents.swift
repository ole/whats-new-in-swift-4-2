/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Enumerating enum cases

 [SE-0194 — Derived Collection of Enum Cases](https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md "Derived Collection of Enum Cases"): The compiler can automatically generate an `allCases` property for enums, providing you with an always-up-to-date list of enum cases. All you have to do is conform your enum to the new `CaseIterable` protocol.
 */
enum Terrain: CaseIterable {
    case water
    case forest
    case desert
    case road
}

Terrain.allCases
Terrain.allCases.count

/*:
 Note that the automatic synthesis only works for enums without associated values — because associated values mean an enum can have a potentially infinite number of possible values.

 You can always implement the protocol manually if the list of all possible values is finite. As an example, here’s a conditional conformance for Optionals of types that are themselves `CaseIterable`:
 */
extension Optional: CaseIterable where Wrapped: CaseIterable {
    public typealias AllCases = [Wrapped?]
    public static var allCases: AllCases {
        return Wrapped.allCases.map { $0 } + [nil]
    }
}

// Note: this isn’t optional chaining!
// We’re accessing a member of the Optional<Terrain> type.
Terrain?.allCases
Terrain?.allCases.count

/*:
 (This is a fun experiment, but I doubt an implementation like this would be very useful in practice. Handle with care.)

 I wrote an article about `CaseIterable` that does into more detail: [Enumerating enum cases in Swift](https://oleb.net/blog/2018/06/enumerating-enum-cases/).
 */
/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
