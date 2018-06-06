/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # `#error` and `#warning` directives

 [SE-0196](https://github.com/apple/swift-evolution/blob/master/proposals/0196-diagnostic-directives.md "Compiler Diagnostic Directives") introduces `#error` and `#warning` directives for triggering a build error or warning in your source code.

 For example, use `#warning` to remember an important TODO before committing your code:
 */
func doSomethingImportant() {
    #warning("TODO: missing implementation")
}
doSomethingImportant()

/*:
 `#error` can be helpful if your code doesn’t support certain environments:
 */
#if canImport(UIKit)
    // ...
#elseif canImport(AppKit)
    // ...
#else
    #error("This playground requires UIKit or AppKit")
#endif

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
