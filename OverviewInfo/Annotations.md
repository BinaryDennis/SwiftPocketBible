# Annotations in Swift

`Remember: Closures Are Reference Types`

## @escaping
- A closure that is saved somewhere in order to be called later (for example, after a function returns) is said to be escaping.
- In Swift 3, closures are non-escaping by default so you'll have to explicitly state @escaping if the closure is saved for later execution

```swift
func printLater(_ f: @escaping () -> String) {   //f is "saved" by DispatchQueue and executed 2 seconds later
    let later : DispatchTime = DispatchTime.now() + 2.0
    
    DispatchQueue.main.asyncAfter(deadline:later) {
        print(f())
    }
}
printLater{"Tomorrow is going to be nice"}
```
 
- In Swift 3.1, you can convert non-escaping closures to escaping ones temporarily by using the new `withoutActuallyEscaping()` helper function. See [SE-0103](https://github.com/apple/swift-evolution/blob/master/proposals/0103-make-noescape-default.md)
```swift
func yourFunction(fn: (Int) -> Int) {  // fn defaults to non-escaping.
  withoutActuallyEscaping(fn) { fn in  // fn is now marked @escaping inside the closure
    // ...
    somearray.lazy.map(fn)             // pass fn to something that is notationally @escaping
    // ...
  }
}
```


## @autoclosure
- use @autoclosure attribute to automatically create a closure around an argument
- works only if the argument is of closure syntax that takes **no input arguments**, _e.g. () -> String_
- caller can pass the argument as a normal parameter instead of using closure syntax

```swift
func printNow(_ f: @autoclosure () -> String) {
    print(f())
}

printNow("What a wonderful day")
```

_Instead of..._

```swift
func printNow(_ f: () -> String) {
    print(f())
}

printNow{"What a wonderful day"}

```

### autoclosure + escaping
```swift
func printLater(_ f:@autoclosure @escaping () -> String) {
    let later : DispatchTime = DispatchTime.now() + 2.0
    
    DispatchQueue.main.asyncAfter(deadline:later) {
        print(f())
    }
}

printLater("Tomorrow is going to be nice")
```


## @available

`@available(...)` attribute *sets* visibility but `if #available(...)` *checks* for visibility

Example
```swift
@available(iOS 11, *)
func styleMe() {
...
}


if #available(iOS 11, *)
 styleMe()
else
 oldStying()
endif
```

@available attributes may be placed directly above any declaration in your code, other than a stored variable. So it works for these:
- Classes
- Structs
- Enums
- Enum cases
- Methods
- Functions

The platforms you can target with @available are these:
- iOS
- OSX
- macOS (alias for OSX)
- tvOS
- watchOS
- iOSApplicationExtension
- OSXApplicationExtension
- tvOSApplicationExtension
- watchOSApplicationExtension

```swift
@available(iOS, introduced: 9.0).  //To indicate the first version of an operating system that a declaration is available
@available(iOS 9.0, *)             //The shorthand, and preferred syntax, for marking the first version available

//multiple introcuded attributes
@available(iOS, introduced: 9.0)
@available(macOS, introduced: 10.12)
// is replaced by
@available(iOS 9.0, macOS 10.12, *)

@available(watchOS, unavailable)  
@available(watchOS, deprecated: 3.0)
@available(watchOS, obsoleted: 3.0)

@available(OSX, deprecated:10.11, message: "Use generateContactInfo()")    //Add a custom warning message
@available(iOS, unavailable, renamed: "NewName")                           //Unavailable method is renamed to... 
```

- In Swift 3.1 the @available attribute can be used to specify Swift version numbers
```swift
@available(swift 3.1)
func intVersion(number: Double) -> Int? {
  return Int(exactly: number)
}
```
 
- In Swift 3.1 the @available attribute can be used to specify platform versions
```swift
@available(swift, introduced: 3.0, obsoleted: 3.1)
func intVersion(number: Double) -> Int {
  return Int(number)
}
```

- Other examples
```swift
if #available(iOS 10.3, *) {
     //do something
}

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#else
    // Not yet supported
#endif
```

**Note: The asterisk in the shorthand syntax tells the compiler that the declaration is available on the minimum deployment target on any other platform.**

For example, `@available(iOS 9.0, *)` states that the declaration is available on iOS 9.0 or greater, as well as on the deployment target of any other platform you support in the project.
On the other hand, `@available(*, unavailable)` states that the declaration is unavailable on every platform supported in your project.
