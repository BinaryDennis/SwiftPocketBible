# Memory Management

For classes, Swift uses automated reference counting (ARC) to manage memory. 
This is done at compile-time and is thus much better than traditional garbage collection which is done at run-time.

Each time a strong reference to an object is created, the (strong) reference count of that object increases.
When that reference is removed, variable holding that reference is set to nil, the (strong) reference count of that object decreases.
Once the (strong) reference count of an object is 0, the object gets deallocted from memory (unless its unowned reference count is not zero, read more about that below).

Swift value types obviosly don't use reference counter as they are copied when passed along.


## Reference types

There are 3 types of references in Swift

1. **Strong**
  - always increases the reference count 
  - can be an _optional_ or not
  - can be _let_ or _var_
  - example: ```var name : String? ```
  
2. **Weak**
  - does not touch reference count
  - will be set to **nil** once the referred objects gets dealloced
  - must be an _optional_
  - must be a _var_
  - example: ```weak var delegate : CallbackDelegate? ```
  
3. **Unowned**
  - does not touch reference count
  - must be an _non-optional_
  - must be a _let_
  - example: ```unowned let window : UIWindow ```


## Reference counters
Each object has 2 reference counters inside of them
1. Reference counter of all **strong** references to this object
2. Reference counter of all **unowned** references to this object

The **weak** reference counter for all objects is stored in a **global table**.

If an objects strong reference count becomes 0, its dealloced from memory, but only if it's unowned reference count is also 0. 
If the unowned reference count is not 0, when the strong reference count becomes 0, the objects memory still allocated but marked as invalid. 
In this case, the will be a runtime crash, when an unowned reference to this object is accessed.
