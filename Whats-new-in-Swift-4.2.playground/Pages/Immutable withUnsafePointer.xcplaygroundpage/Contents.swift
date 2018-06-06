/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous)

 # Calling `withUnsafePointer(to:_:)` and `withUnsafeBytes(of:_:)` with immutable values

 This is a small thing, but if you ever had to use the top-level functions `withUnsafePointer(to:_:)` and `withUnsafeBytes(of:_:)`, you may have noticed that they required their argument to be a mutable value because the parameter was `inout`.

 [SE-0205](https://github.com/apple/swift-evolution/blob/master/proposals/0205-withUnsafePointer-for-lets.md "withUnsafePointer(to:_:) and withUnsafeBytes(of:_:) for immutable values") adds overloads that work with immutable values.
 */
let x: UInt16 = 0xabcd
let (firstByte, secondByte) = withUnsafeBytes(of: x) { ptr in
    (ptr[0], ptr[1])
}
String(firstByte, radix: 16)
String(secondByte, radix: 16)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous)
 */
