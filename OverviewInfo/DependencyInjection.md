# Dependency Injection

There are various techniques for taking a dependency and injecting something else in its place. 

**Swizzling**, dynamically replacing one method with another, is one technique. 
Some even argue that swizzling makes DI unnecessary, but most will argue that its better to have code that makes dependencies explicit, so they are visible, for example in test cases.

There are a few types of dependency injection:
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
In property injection, a dependency is assumed to have been set in a variable, for later use. 

The advantage and disadvantage of property injection is that it separates initialization from injection.

Making a property injection robust is **surprisingly tricky**. For example, do you need to make the getter thread-safe? Should you guard against the property being reset arbitrarily? What is a good candidate as a default value? Make sure the default value doesn’t refer to another library!


```swift
//see Printer and LaserPrinter definitions in example for Constructor injection

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
            if _printer == nil {
                _printer = newValue
            }
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
In Method injection, a dependency is simply passed as an argument to the method. 

Method injection is good when the dependency will vary with each call. This could perhpas be a random number or the current time.

```swift
//see Printer and LaserPrinter definitions in example for Constructor injection

class Secretary {
    
    func pleasePrint(papers: [String], printer: Printer) {
        for paper in papers {
            printer.print(paper: paper)
        }
    }
}

```

## 4. Ambient Context
When the dependency is accessed through a class method (such as a singleton), then there are two ways to control that dependency from a test:

1. If you control the singleton, you may be able to expose its properties to control its state.

2. If fiddling with properties is insufficient, or the singleton isn’t yours to control, then it’s time to **swizzle**: replace the class method so that it returns the fake you need.

Also, if you have a dependency that cuts cross layers of functionaltiy, it migth be better to use an ambient context, i.e. a **global object**. A good candidate for this is logging or analytics. 

Just be aware in your test files to **reset** the global object, in _setup()_ and _tearDown()_.

```swift
//FIX example
```

## 5. Extract and Override Call
Extract and Override Call consists of 4 parts.

1. Extract all references to the dependency into a new method
2. Change other places where the dependency is referenced, replacing them with calls to the new method
3. Create a special testing subclass
4. Override the newly added method

Because extract and override call is so simple and powerful, you may be tempted to use it everywhere. But because it requires test-specific subclasses, it’s easy for tests to become fragile.
That said, it’s effective with legacy code, especially when you don’t want to change all the calling points

```swift
//see Printer and LaserPrinter definitions in example for Constructor injection

struct StubPrinter: Printer {
    func print(paper: String) -> String {
        return "I can't print, Im a dumb stub"
    }
}

class Secretary {
    
    func pleasePrint(papers: [String]) {
        for paper in papers {
            printer().print(paper: paper)
        }
    }
    
    func printer() -> Printer {
        return LaserPrinter()
    }
}



class TestSecretary : Secretary {
    
    override func printer() -> Printer {
        return StubPrinter()
    }
}
```

