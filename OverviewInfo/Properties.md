# Swift properties


## Initialization of properites

Normally a property is initialized in one line

```swift
  let oneLineInitializedProperty : Int = 5
```

But for properties that require more than a one-liner to be initialized, there is a special syntax: `= {}()`

When the property is first accessed, the closure is executed (only once, note the parentheses at the end), and its return value is stored in the property. 

```swift  
  let multilineInitilizedProperty: Int = {
    //custom code calculating the value
    //return the value
  }()
```

## Stored properties

- `var` or `let`
- `struct` and `class` (not enum nor extension)

```swift
class TeslaCar {
    var modelName: String?
}

struct TeslaCar {
    let modelName: String
    var price: Int
}
```

## Computed properties

- only `var`
- `struct`, `class`, `enum` and `extension`
- `closure` syntax

```swift
class TeslaCarModel3 {
    var modelName: String {
        return "Model 3"
    }
}

struct TeslaCarModelS {
    var modelName: String {
        return "Model S"
    }
}

enum TeslaCarModelX {
    var modelName: String {
        return "Model X"
    }
}

extension TeslaCarModelS {
    var price : Int {
        return 70_000
    }
}
```

## Lazy stored propterties

- only `var`
- `struct` and `class` (not enum nor extension)
- prefix `lazy`

```swift
class TeslaCarModel3 {
    lazy var modelName: String = "Model 3"
}

struct TeslaCarModelS {
    lazy var modelName: String = "Model S"
}
```

```swift
class TeslaCar {

    private let modelName: String!

    //This is a lazy loaded property which requires more than one line to initialize and references self
    lazy var priceForCustomers: Int = {
        switch (self.modelName) { //In lazily loaded varaibles, self must be used explicitly!
        case "Model 3": return 30_000
        case "Model S": return 70_000
        default: return 100_000
        }
    }()

    init(modelName: String) {
        self.modelName = modelName
    }
}
```
