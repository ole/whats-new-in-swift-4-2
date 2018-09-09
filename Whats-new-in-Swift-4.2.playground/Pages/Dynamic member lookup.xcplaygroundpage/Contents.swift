/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # Dynamic member lookup

 [SE-0195](https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md "Introduce User-defined 'Dynamic Member Lookup' Types") introduces the `@dynamicMemberLookup` attribute for type declarations.

 A variable of a `@dynamicMemberLookup` type can be called with _any_ property-style accessor (using dot notation) — the compiler won’t check if a member with the given name exists or not. Instead, the compiler translates such accesses into calls of a subscript accessor that gets passed the member name as a string.

 The goal of this feature is to facilitate interoperability between Swift and dynamic languages such as Python. The [Swift for TensorFlow](https://github.com/tensorflow/swift) team at Google, who has driven this proposal, implemented a Python bridge that makes it possible to [call Python code from Swift](https://github.com/tensorflow/swift/blob/master/docs/PythonInteroperability.md). Pedro José Pereira Vieito packaged this up in a SwiftPM package called [PythonKit](https://github.com/pvieito/PythonKit).

 SE-0195 isn’t required to enable this interoperability, but it makes the resulting Swift syntax much nicer. It’s worth noting that SE-0195 only deals with property-style member lookup (i.e. simple getters and setters with no arguments). A complementary ["dynamic callable" proposal (SE-0216)](https://github.com/apple/swift-evolution/blob/master/proposals/0216-dynamic-callable.md)) for a dynamic method call syntax has been accepted, but didn’t make the cut for Swift 4.2. It will be part of the next Swift release.

 Although Python has been the primary focus of the people who worked on the proposal, interop layers with other dynamic languages like Ruby or JavaScript will also be able to take advantage of it.

 And it’s not limited to this one use case, either. Any type that currently has a string-based subscript-style API could be converted to dynamic member lookup style. SE-0195 shows a `JSON` type as an example where you can drill down into nested dictionaries using dot notation.

 Here’s another example, courtesy of Doug Gregor: an `Environment` type that gives you property-style access to your process’s environment variables. Note that mutations also work.
 */
import Darwin

/// The current process's environment.
///
/// - Author: Doug Gregor, https://gist.github.com/DougGregor/68259dd47d9711b27cbbfde3e89604e8
@dynamicMemberLookup
struct Environment {
    subscript(dynamicMember name: String) -> String? {
        get {
            guard let value = getenv(name) else { return nil }
            return String(validatingUTF8: value)
        }
        nonmutating set {
            if let value = newValue {
                setenv(name, value, /*overwrite:*/ 1)
            } else {
                unsetenv(name)
            }
        }
    }
}

let environment = Environment()

environment.USER
environment.HOME
environment.PATH

// Mutations are allowed if the subscript has a setter
environment.MY_VAR = "Hello world"
environment.MY_VAR

/*:
 This is a big feature that has the potential to change how Swift is used in fundamental ways if misused. By hiding a fundamentally “unsafe” string-based access behind a seemingly “safe” construct, you may give readers of your code the wrong impression that things have been checked by the compiler.

 Before you adopt this in your own code, ask yourself if `environment.USER` is really that much more readable than `environment["USER"]` to be worth the downsides. In most situations, I think the answer should be “no”.

 I wrote an article about `@dynamicMemberLookup` that goes into more detail: [Thoughts on @dynamicMemberLookup](https://oleb.net/blog/2018/06/dynamic-member-lookup/).
 */
/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
