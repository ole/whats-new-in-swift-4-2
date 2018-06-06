/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # `MemoryLayout.offset(of:)`

 [SE-0210](https://github.com/apple/swift-evolution/blob/master/proposals/0210-key-path-offset.md "Add an offset(of:) method to MemoryLayout") adds an `offset(of:)` method to the `MemoryLayout` type, complementing the existing APIs for getting a type’s size, stride, and alignment.

 The `offset(of:)` method takes a key path to a type’s stored property and returns the property’s byte offset. An example where this is useful is passing an array of interleaved pixel values to a graphics API.
 */
struct Point {
    var x: Float
    var y: Float
    var z: Float
}

MemoryLayout<Point>.offset(of: \Point.z)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
