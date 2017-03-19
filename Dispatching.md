# Swift method dispatching

Free functions, and methods called on structs, are _statically_ dispatched. 
This means the function that'll be called is known at compile time. 
This also means the compiler might be able to **inline** the function, i.e. not call the function at all, but instead replace it with the code the function would execute.

Methods on classes or protocols can be _dynamically_ dispatched. 

## Polymorphism
Polymorphic behavior, i.e. behavior that varies depending on the types involved, can be achieved in 3 ways in Swift

1. Subclassing and overriding methods of parent class **[dynamic dispatch]**
2. Function overloading - where a function is written multiple times for different types **[static dispatch]**
3. Generics **[static dispatch]**

### Subclassing


### Function overloading  
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

### Generics


