/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # `#if compiler` version directive

 [SE-0212](https://github.com/apple/swift-evolution/blob/master/proposals/0212-compiler-version-directive.md "Compiler Version Directive") introduces a `compiler` directive for use in compile-time conditionals using `#if`.

 It has the same syntax as the existing `#if swift(>=4.2)` syntax, but `#if compiler` checks against the actual _compiler version_, regardless of which compatibility mode it’s running in, whereas `#if swift` is a _language version_ check.

 For example, `#if swift(>=4.2)` would be false when running Swift 4.2 in Swift-4.0 compatibility mode, but `#if compiler(>=4.2)` would be true in this case. The proposal has many more examples how complicated some `#if swift` checks can become and how the `compiler` directive simplifies them.
 */

#if compiler(>=4.2)
print("Using the Swift 4.2 compiler or greater in any compatibility mode")
#endif

#if swift(>=4.2)
print("Using the Swift 4.2 compiler or greater in Swift 4.2 or greater compatibility mode")
#endif

#if compiler(>=5.0)
print("Using the Swift 5.0 compiler or greater in any compatibility mode")
#endif

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
