# Memory Management

Swift does not have a garbage collection system like Java, that frees up unused memory in _run-time_.
Instead Swift has something called **ARC**, Automatic Reference Counting, which is a _compile-time_ memory management system.

_Reference_ types in Swift (e.g. Classes), are handled by ARC. But _value_ types (e.g. Structs, Strings) obviously don't need reference counting since they are copied when passed along.

Each time a strong reference to an object is created, the (strong) _reference count_ of that object increases.
When that reference is removed (variable holding that reference is set to nil), the (strong) reference count of that object decreases.
Once the (strong) reference count of an object is 0, the object gets deallocted from memory (unless its unowned reference count is not zero, read more about that below).

In essence, as long as anything has a strong reference to an object, it will not be deallocated.
 
If a closure captures a variable that is a reference type, then the closure will maintain a strong reference (increasing its strong reference count) to that object. To avoid strong references in closures, use a **capture list** and specify _weak_ or _unowned_ before the variable name.
```swift
controller.delegate = { [weak view] in
  print("the view: \(view)")
}
```



## References

There are 3 ways of referencing in Swift

1. **Strong**
  - is the default reference type
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
By default, variables are of type _strong_ if nothing else stated. Strong references can safely be used in situtations where there is a **linear** relationship (in opposite to **circular** relationship), i.e. when a parent object references a child object (may be recursive) and the child object _never_ references back to the parent object. 


```swift
class Book {
    let author = Author() //strong reference to Author (which is a child object to Book)
}
class Author {
    let address = Address() //strong reference to Address (which is a child object to Author)
}

class Address {   
}

```

Keep in mind to avoid creating **strong** reference cycles (ie. creating circular relationships between parent & child objects using only strong references).


### weak
The `Person` and `Apartment` example below, shows a situation where two properties, **both of which are allowed to be nil**, have the **potential to cause a strong reference cycle**. This scenario is best resolved with a weak reference.


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



### unowned

The `Customer` and `CreditCard` example below shows a situation where one property that is **allowed to be nil** and another property that **cannot be nil** have the **potential to cause a strong reference cycle**. This scenario is best resolved with an unowned reference.


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

### unowned + implicitly unwrapped optional

There is a third scenario, in which **both properties should always have a value**, and **neither property should ever be nil** once initialization is complete. In this scenario, it is useful to combine an `unowned` property on one class with an _implicitly unwrapped optional property_ on the other class.

This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still **avoiding a strong reference cycle**.

```swift
class Country {
    let name: String

    var capitalCity: City!    //a country must have a captital city at all times. Implicitly unrwapped optional

    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
 
class City {
    let name: String
    
    unowned let country: Country   //a city must belong to a country at all times. 
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Sweden", capitalName: "Stockholm")

```

## Reference cycles in blocks 
Blocks "captures" variables outside itself as `strong` (default value), `weak` or `unowned`. 
 
Use a **capture list** to specify how the block shall "capture" variables. 


```swift
func send(message: String, completionBlock: () -> ()) -> Void {
    //send message somehow, perhaps asynchronous and upon response execute the completion block
    completionBlock()   //execute completion block
}


send(message: "Hello world", 
     completionBlock: { 
        self.showSuccessMessage()     //strong reference to self
     })


send(message: "Hello world", 
     completionBlock: { [weak self] in
        self.showSuccessMessage()     //weak reference to self
     })
```

### Functions are blocks too
A function is simply a block with a name. This means that anywhere a block is expected, a function could be sent instead.

In a block, you can use `weak` in the capture list, but using a function instead, a `weak` reference to that variable before created **before** calling the function. 

```swift
func send(message: String, completionBlock: () -> ()) -> Void {
    //send message somehow, perhaps asynchronous and upon response execute the completion block
    completionBlock()   //execute completion block
}

func showSuccessMessage() {
 //show something cool
}

send(message: "Hello world", 
     completionBlock: self.showSuccessMessage) //strong reference to self

weak var weakSelf = self
send(message: "Hello world", 
     completionBlock: weakSelf?.showSuccessMessage) //weak reference to self

```



