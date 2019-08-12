# Attributes

## final
cannot subclass. compiler will optimise.

## class
can subclass

## static
Static

## dynamic
Dynamic declaration tells the compiler that dynamic dispatch should be used to access that member.

By prefixing a declaration with the dynamic keyword, the declaration is implicitly marked with the `@objc` attribute.

```swift 
class Test {
  dynamic var name: String
}
```

## @objc
The objc attribute makes the declaration available in Objective-C, which is a requirement for it to be dispatched by the Objective-C runtime.

```swift 
class Test {
  @objc func callMe() {}
}
```


## inline

