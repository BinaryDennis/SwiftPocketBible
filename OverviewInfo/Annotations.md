# Annotations in Swift

`Remember: Closures Are Reference Types`

## @escaping
* A closure that is saved somewhere in order to be called later (for example, after a function returns) is said to be escaping.
* In Swift 3, closures are non-escaping by default.

```swift
func printLater(_ f: @escaping () -> String) {   //f is "saved" by DispatchQueue and executed 2 seconds later
    let later : DispatchTime = DispatchTime.now() + 2.0
    
    DispatchQueue.main.asyncAfter(deadline:later) {
        print(f())
    }
}
printLater{"Tomorrow is going to be nice"}

```
 

## @autoclosure
* @autoclosure attribute to automatically create a closure around an argument
* work only if the argument is a closure/block that takes **no input arguments**, _e.g. () -> String_
* makes the caller side a bit more convenient, i.e. does not have to pass in the argument with block syntax

```swift
func printNow(_ f: @autoclosure () -> String) {
    print(f())
}

printNow("What a wonderful day")
```

Instead of...

```swift
func printNow(_ f: () -> String) {
    print(f())
}

printNow{"What a wonderful day"}

```

autoclosure + escaping
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

* can be used to deprecate methods (you will receive a warning where the method is called)
```swift
@available(*, deprecated)
func myDeprecatedMethod() { 
// ...
}
```
