# Dependency Injection

There are various techniques for taking a dependency and injecting something else in its place. 
Swizzling, dynamically replacing one method with another, is one technique. 
Some even argue that swizzling makes DI unnecessary, but most will argue that its better to have code that makes dependencies explicit, so they are visible, for example in test cases.

There are a few types of dependency injection

1. Constructor injection
2. Property Injection
3. Method Injection
4. Ambient Context
5. Extract and Override Call


## 1. Construction Injection
In constructor injection, a dependency is passed into the constructor and captured for later use.
Constructor injection should be your **weapon of choice**. When in doubt, start here. The advantage is that it makes dependencies explicit.

```swift
protocol Printer {
    func print(paper: String) -> String
}

struct LaserPrinter : Printer {
    
    func print(paper: String) -> String {
        return "printing..." + paper
    }
}

class Secretary {
    let printer: Printer

    init(printer: Printer) {
        self.printer = printer
    }
    
    func pleasePrint(papers: [String]) {
        for paper in papers {
            self.printer.print(paper: paper)
        }
    }
}
```

## 2. Property Injection
In constructor injection, a dependency is passed into the constructor and captured for later use.

```swift
protocol Printer {
    func print(paper: String) -> String
}

struct LaserPrinter : Printer {
    
    func print(paper: String) -> String {
        return "printing..." + paper
    }
}

class Secretary {
    private var _printer : Printer?
    
    var printer: Printer {
        //In case the printer has not been set by client
        //before its needed, eg in pleasePrint(), fallback
        //on a default printer
        get {
            if _printer == nil {
                _printer = LaserPrinter()
            }
            return _printer!
        }
        set {
            _printer = newValue
        }
    }

    func pleasePrint(papers: [String]) {
        for paper in papers {
            self.printer.print(paper: paper)
        }
    }
}
```

## 3. Method Injection
In constructor injection, a dependency is passed into the constructor and captured for later use.

```swift
//FIX example
```

## 4. Ambient Context
In constructor injection, a dependency is passed into the constructor and captured for later use.

```swift
//FIX example
```

## 5. Extract and Override Call
In constructor injection, a dependency is passed into the constructor and captured for later use.

```swift
//FIX example
```

