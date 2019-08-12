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

## some
The `some` attributes is used to return back `Opaque` types. This solves the Self-requirement problem in Protocols.

```swift 
protocol Fruit { }

func giveFruits() -> [Fruit] { ... }

///extension Fruit: Equatable <<--- compilation error. Fruit can only be used as a generic constraint because it has Self or associated type requirements.
```

U cant compare things conforming to Fruit, because you dont know what their types (hidden behind the protocol-wrapper) are. The protocol is "non-opaque". 
```swift
struct Apple: Fruit { ... }
extension Int: Fruit { }

//would not make sense to compare two things conforming to Fruit protocol
```

But using attribute `some` will return `opaque` types which solve this problem, because even though we just see a protocol being used, internally the Swift compiler knows exactly what that protocol actually resolves to.

```swift
func giveFruits() -> some [Fruit] { ... }
```

An important note here is that functions with opaque return types must always return one specific type.
 
## inline
bla bla bla
