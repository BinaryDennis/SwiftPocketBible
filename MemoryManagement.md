# Memory Management

For _reference_ types, i.e. classes and functions (including closures), Swift uses automated reference counting (ARC) to manage memory. 
This is done at compile-time and is thus much better than traditional garbage collection which is done at run-time.

Each time a strong reference to an object is created, the (strong) reference count of that object increases.
When that reference is removed, variable holding that reference is set to nil, the (strong) reference count of that object decreases.
Once the (strong) reference count of an object is 0, the object gets deallocted from memory (unless its unowned reference count is not zero, read more about that below).

If a closure captures a variable that is a reference type, then the closure will maintain a strong reference (increasing its strong reference count) to that object. To avoid strong references in closures, use a **capture list** and specify _weak_ or _unowned_ before the variable name.
```swift
controller.delegate = { [weak view] in
  print("the view: \(view)")
}
```

Swift _value_ types obviosly don't use reference counter as they are copied when passed along.


## References

There are 3 ways of referencing in Swift

1. **Strong**
  - always increases the reference count 
  - can be an _optional_ or not
  - can be _let_ or _var_
  ```swift
    // examaple:
    var name : String?
  ```
  
2. **Weak**
  - does not touch reference count
  - will be set to **nil** once the referred objects gets dealloced
  - must be an _optional_
  - must be a _var_
  ```swift 
    // examaple:
    weak var delegate : CallbackDelegate? 
  ```
  
3. **Unowned**
  - does not touch reference count
  - must be an _non-optional_
  - must be a _let_
  ```swift
    // examaple:
    unowned let window : UIWindow 
  ```


## Reference counters
Each object, that is of reference type, has 2 embedded reference counters
1. Reference counter of all **strong** references to it self
2. Reference counter of all **unowned** references to it self

The **weak** reference counter for all reference type objects is stored in a **global table**, thus unowned is faster than weak.

If an objects strong reference count becomes 0, its dealloced from memory, but only if it's unowned reference count is also 0. 
If the unowned reference count is not 0, when the strong reference count becomes 0, the objects memory still allocated but marked as invalid. This is whats called a **zombie** memory/object. Accessing a zombie object will result in a run-time crash.
