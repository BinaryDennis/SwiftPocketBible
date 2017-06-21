# Swift method dispatching

Free functions, and methods called on structs, are _statically_ dispatched. 
This means the function that'll be called is known at compile time. 
This also means the compiler might be able to **inline** the function, i.e. not call the function at all, but instead replace it with the code the function would execute.

Methods on classes or protocols can be _dynamically_ dispatched. 

## Polymorphism
Polymorphic behavior, i.e. behavior that varies depending on the types involved, can be achieved in 4 ways in Swift

1. Inheritance: Subclassing and overriding methods of parent class **[dynamic dispatch]**
2. Function overloading - where a function is written multiple times for different types **[static dispatch]**
3. Generics **[static dispatch]**
4. Protocol methods **[static or dynamic]**

### 1. Inheritance: Subclassing
Subclassing obviously uses **dynamic** dispatching.

```swift
class Orange {
    var price : Int { return 5 }
}

class RedOrange : Orange {
    override var price: Int { return 7 }
}

//fruit's static type is Orange but its dynamic type is RedOrange
let fruit : Orange = RedOrange()
fruit.price   //dispatched dynamically -> 7
```


### 2. Function overloading  
It’s important to note that overloads are **resolved statically** at compile time. 
This means the compiler bases its decision of which overload to call on the static types of the variables involved, and not on the values' dynamic types at runtime.

Swift always favors the most specialized implementation of a function or method.

```swift
class Animal {
  var name: String
  
  init(name: String) {
    self.name = name
  }
}

class Dog : Animal {
}

func makeNoise(_ dog: Dog) {
    print(dog.name + "says woff")
}
func makeNoise(_ animal: Animal) {
    print(animal.name + "says muu")
}

let dog1 = Dog(name: "bella")
let dog2 : Animal = dog1

makeNoise(dog1)  //bella says woff
makeNoise(dog2)  //bella says muuu   - statically dog2 is of type Animal and not Dog
```

### 3. Generics

TO BE ADDED


### 4. Protocols
Generic programming in Swift wouldn’t be possible without protocols.

Protocol requirements are dispatched **dynamically**, whereas methods that are only defined in an extension use **static** dispatch.

```swift

protocol Printable {
    func printPdf()  //dispatched dynamically since its part of the protocol requirement
}

extension Printable {
    
    //default implementation of printPdf() protocol requirement
    func printPdf() {
        print("printPdf from protocol extension")
    }

    func printDoc() {  //not part of the protocol definition - hence its statically dispatched
        print("printDoc from protocol extension")
    }
}


struct Photo : Printable {
    
    func printPdf() {
        print("printPdf from Photo")
    }
    
    func printDoc() {
        print("printDoc from Photo")
    }
}

//p1's static type is Printable but its dynamic type is Photo
let p1 : Printable = Photo()
p1.printPdf()  //dispatched dynamically -> "printPdf from Photo"
p1.printDoc()  //dispatched statically ->  "printDoc from protocol extension"

//p2's static and dynamic types are both Photo
let p2 : Photo = Photo()
p2.printPdf()  //dispatched dynamically -> "printPdf from Photo"
p2.printDoc()  //dispatched dynamically -> "printDoc from Photo"

```

### Extra: Inheritance + Protocols
Some solutions might need to utilize both protocols and subclassing, do how does the dispatching work in these cases? 
The short answer is that **Inheritance dispatching > Protocol dispatching**

```swift
protocol Printable {
    func printPdf()  //dispatched dynamically since its part of the protocol requirement
}

extension Printable {
    
    //default implementation of printPdf() protocol requirement
    func printPdf() {
        print("printPdf from protocol extension")
    }

    func printDoc() {  //not part of the protocol definition - hence its statically dispatched
        print("printDoc from protocol extension")
    }
}


class Chart: Printable {
    
}

class PieChart : Chart {
    //Note that this is method printPdf is not dynamically dispatched although
    //printPdf is part of the protocol requirement which PieChart indirectly
    //(by being a subclass to Chart) conforms to
    
    //In this case the super class, Chart, has not explicity defined the method
    //printPdf (because it gets the protocol extensions default implementation),
    //so the subclass PieChart cannot use the reserved word 'override' in order
    //to utilize dynamic dispatching of subclassing (inheritance)
    //To solve this, see example with Diagram and ColorDiagram
    func printPdf() {
        print("printPdf from PieChart")
    }
}

//p3's static type is Printable but its dynamic type is PieChart
let p3 : Printable = PieChart()
p3.printPdf() //dispatched statically -> "printPdf from protocol extension"
p3.printDoc() //dispatched statically -> "printDoc from protocol extension"


class Diagram : Printable {
    
    //explicitly define the protocol requirement method
    //although it has a default implementation so that
    //any sub-class may override this method
    func printPdf() {
        print("printPdf from Diagram")
    }
}

class ColorDiagram : Diagram {
    
    //override super-class method printPdf to get dynamic dispatching
    override func printPdf() {
        print("printPdf from ColorDiagram")
    }
    
    func printDoc() {
        print("printDoc from ColorDiagram")
    }
}

//p4's static type is Printable but its dynamic type is ColorDiagram
let p4 : Printable = ColorDiagram()
p4.printPdf()  //dispatched dynamically -> "printPdf from ColorDiagram"
p4.printDoc()  //dispatched statically  -> "printDoc from protocol extension"
```


