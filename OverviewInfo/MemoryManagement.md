# Memory Management

For _reference_ types, i.e. classes, Swift uses automated reference counting (ARC) to manage memory. 
This is done at compile-time and is thus much better than traditional garbage collection which is done at run-time.

Each time a strong reference to an object is created, the (strong) reference count of that object increases.
When that reference is removed (variable holding that reference is set to nil), the (strong) reference count of that object decreases.
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


## How to use?

### strong
Avoid creating **strong** reference cycles!

### weak
```swift
class Person {
    let name: String
   
    init(name: String) { self.name = name }
    
    var apartment: Apartment?  //a person may or may not have an appartment

}
 
class Apartment {
    let unit: String
    
    init(unit: String) { self.unit = unit }
    
    weak var tenant: Person? //an apartment may have no tenant at some point in its lifetime

}
```

Use a weak reference to avoid reference cycles whenever it is possible for that reference to have a missing value at some point in its life. If the reference **always** has a value, use an _unowned_ reference instead.

In the Apartment example above, it is appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case.



### unowned
```swift
class Customer {
    let name: String
    
    var card: CreditCard?   //a customer may or may not have a credit card
    
    init(name: String) {
        self.name = name
    }
}
 
class CreditCard {
    let number: UInt64
    
    unowned let customer: Customer.  //but a credit card will always be associated with a customer

    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
}

```

In the example above, a customer may or may not have a credit card, but a credit card will **always** be associated with a customer, so an _unowned_ reference is used to break a potential strong reference cycle.





