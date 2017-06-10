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


**FIXME: MORE TO BE ADDED**

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

- @available can also be used to deprecate methods (you will receive a warning where the method is called)
```swift
@available(*, deprecated)
func myDeprecatedMethod() { 
  // ...
}
```
