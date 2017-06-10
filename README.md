# :blue_book: The Swift Pocket Bible
The **Swift Pocket Bible** is a collection of brief explanations and examples of various important aspects of Swift :sparkles:


## Overview info
In the `OverviewInfo` folder there are a handful of markdown files briefly explaining various important aspects of Swift, eg:

- :floppy_disk: Swift [Memory management](OverviewInfo/MemoryManagement.md)
- :mailbox_with_mail: Swift [Dispatching](OverviewInfo/Dispatching.md)
- :syringe: [Dependency Injection](OverviewInfo/DependencyInjection.md) in Swift
- :closed_lock_with_key: [Thread Safety](OverviewInfo/ThreadSafety.md) in Swift
- :id: Swift [Meta Types](OverviewInfo/MetaTypes.md)
- :pencil2: How to [comment](OverviewInfo/Commenting.md) in Swift files
- :underage: [Access control](OverviewInfo/AccessControl.md) in Swift
- :cyclone: [Annotations](OverviewInfo/Annotations.md) in Swift
  

## Extensions
In the `Extensions` folder there are a handful of useful Extensions, e.g.:

- [Date+ISI8601](Extensions/Date+ISO8601.swift)
- [Color+Hex](Extensions/UIColor+Hex.swift)
- [UIImage+Color](Extensions/UIImage+Color.swift)
- [UIImage+Cropping](Extensions/UIImage+Cropping.swift)
- [UIImageView+AsyncLoading](Extensions/UIImageView+AsyncLoading.swift)
- [UIScrollView+Center](Extensions/UIScrollView+Center.swift)
- [UIView+Image](Extensions/UIView+Image.swift)
- [UIView+ResponderChain](Extensions/UIView+ResponderChain.swift)



## Examples
  In the `Examples` folder there are a handful of examples, e.g.:

 - [Swizzling](Examples/UIViewController+Swizzling.swift)
 - [Associated objects](Examples/UIViewController+AscObject.swift)
 - [Protocols](Examples/ProtocolExamples.swift)



## To be added
- [ ] [Protocol examples]  
- [ ] More about protocols (class-only protocol, eg : class) + Delegates
- [ ] [Swift meta types]
- [ ] How to choose between struct or class
- [ ] Background tasker
- [ ] extension on Int  1.million
- [ ] operations on collections that are missing in std-lib (ex from Advanced Swift Book)
- [ ] copy-on-write for custom class as example
- [ ] dynamic dispatch as example
- [ ] alertview extension to show alert from anywhere
- [ ] custom fun iterators
- [ ] nsuserdefaults wrapper
- [ ] multipart datatask request
- [ ] Link to design patterns
- [ ] GCD breif  overview and examples
- [ ] Operation breif  overview and examples
- [ ] final, class, static
- [ ] Swift properties examples
- [ ] Run loop modes (see https://developer.apple.com/videos/play/wwdc2012/223/)
- [ ] UIResponderChain
- [ ] Array/Collection value or reference types based on its element
- [ ] Example of custom collection and sequence
- [ ] find top most view controller


## other stuff
- [ ] queue
- [ ] dequeue
- [ ] binary search tree
- [ ] priority queue
- [ ] double linked list
- [ ] linked list
- [ ] stack
- [ ] mergeSort, quickSort & insertionSort
- [ ] binarySearch
- [ ] numberOfOccurances
- [ ] map, filter, reduce, flatmap as example
- [ ] isPalindrome
- [ ] findMaxSingleSellProfit


### Swift 3.1 highlights
Swift 3.1 adds two new functions for data filtering to the standard library’s Sequence protocol, `.prefix(while:)` and `.drop(while:)`

```swift
let interval = fibonacci.prefix(while: {$0 < 1000}).drop(while: {$0 < 100})
for element in interval {
  print(element) // 144 233 377 610 987
}
```

Swift 3.1 implements failable initializers for all numeric types.
```swift
//If gradeDouble is a fractional value, such as 6.33, it will fail. 
//If it can be represented exactly with an Int, such as 6.0, it will succeed
let grade = Int(exactly: gradeDouble)
```


Swift 3.1 lets you extend a generic type with a concrete type constraint. Previously, you couldn’t extend a type like this because the constraint had to be a protocol.
```swift
// Swift 3.1
extension Optional where Wrapped == String {
  var isBlank: Bool {
    return self?.isBlank ?? true
  }
}
```

Swift 3.1 allows you to mix nested types with generics.
```swift
class Directory<T> {

  class File {
     let title: T
  }
  
  let title: T
}
```




