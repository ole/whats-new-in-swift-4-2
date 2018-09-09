/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Implicitly unwrapped optionals

 [SE-0054](https://github.com/apple/swift-evolution/blob/master/proposals/0054-abolish-iuo.md "Abolish ImplicitlyUnwrappedOptional type") was accepted already in March 2016, but it took until Swift 4.2 to implement it completely.

 In Swift 4.2, [implicitly unwrapped optionals](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID334) still exist — that is, you can annotate a type declaration with a `!` instead of a `?` to declare an optional value that will be unwrapped automatically. But there isn’t a separate `ImplicitlyUnwrappedOptional` type anymore.

 Instead, implicitly unwrapped optionals are just normal optionals (and have the type `Optional<T>`) with a special annotation that tells the compiler to automatically add a force-unwrap when needed.

 There is a great article on the official Swift blog that goes into much more detail about the implications of this change: [Reimplementation of Implicitly Unwrapped Optionals](https://swift.org/blog/iuo/).
 */

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
