/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)

 # `guard let self = self`

 [SE-0079](https://github.com/apple/swift-evolution/blob/master/proposals/0079-upgrade-self-from-weak-to-strong.md "Allow using optional binding to upgrade self from a weak to strong reference") is another proposal that was originally accepted for Swift 3.0 but took a while to get implemented.

 It allows rebinding `self` from a weak (and optional) variable to a strong variable by using optional binding. That, is, you can now write `if let self = self { … }` or `guard let self = self else { … }` in a closure expression that has captured `self` weakly to conditionally rebind `self` to a strong variable within the scope of the `if let` or `guard let` statement.
 */

import Dispatch

struct Book {
    var title: String
    var author: String
}

func loadBooks(completion: @escaping ([Book]) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        DispatchQueue.main.async {
            completion([
                Book(title: "Harry Potter and the Deathly Hallows", author: "JK Rowling"),
                Book(title: "Pippi Långstrump", author: "Astrid Lindgren")])
        }
    }
}

class ViewController {
    var items: [Book] = []

    func viewDidLoad() {
        loadBooks { [weak self] books in
            // This is now allowed
            guard let self = self else {
                return
            }
            self.items = books
            self.updateUI()
        }
    }

    func updateUI() {
        // ...
    }
}

/*:
 In previous Swift versions, it was possible to rebind `self` by wrapping the name in backticks, and many developers favored this over coming up with a new name, such as `strongSelf`. However, the fact that this worked was [a bug, not a feature](https://github.com/apple/swift-evolution/blob/master/proposals/0079-upgrade-self-from-weak-to-strong.md#relying-on-a-compiler-bug).
 */
/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
