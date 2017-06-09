# Annotations in Swift


## @autoclosure
* used in method paramters that are of closure/block type, *eg () -> Bool*
* work only if the closure/block parameter takes **no input arguments**
* makes the caller side a bit more convenient, i.e. does not have to pass in that parameter as block syntax

```swift


```


## @escaping

## @available

* can be used to deprecate methods (you will receive a warning where the method is called)
```swift
@available(*, deprecated)
func myDeprecatedMethod() { 
// ...
}
```
