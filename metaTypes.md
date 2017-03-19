# Swift Meta types


- **type(of:)**
  _Returns the Type of the object (dynamic type)_

- **.Type**
  _Dog.Type means that the Dog type itself is expected (or the type of one of its subclasses), not a instance!_

- **.self**
  _To pass the Dog type where Dog.Type is expected, you can pass Dog.self._

- **self**
  _the current instance_

- **Self**
  _An instance of whatever type this is at runtime_


```swift

class Animal {
    var name : String
    
    init() {
        name = "Giraff"
    }
    
	//Every subclass of Animal must inherit or reimplement init(name:)
    required init(name:String) {
        self.name = name
    }

	// class method & factory method
    // Self - "an instance of whatever type this is at runtime." 
	// self - in a class methods, refers to the static type
    class func makeAndName() -> Self {
		return self.init(name:"Fido")
    }
    
	// in normal methods, not class methods, use type(of:) on the instance to get type and then init
    func havePuppy(name:String) -> Self {
        return type(of:self).init(name:name)
    }
            
}

class Dog : Animal {
    var race : String
    
    override init() {
        race = "bulldog"
        super.init()
    }
    
    required init(name: String) {
        race = "pincher"
        super.init(name: name)
    }
}

func createAnimalInstance(of typeName: Animal.Type) -> Animal {
    //the compiler is in doubt as to whether the init(name:) initializer is implemented by every possible subtype of Animal. To reassure it, we must declare that initializer with the required keyword
    
	return typeName.init(name: "unanmed")
}

let dog = createAnimalInstance(of: Dog.self)
//dog.race  //will not compile since dogs static type is Animal but dynamic type is Dog

let name = type(of:dog)  //Returns the dynamic type which in this case is Dog

let anotherDog = Dog()
let puppy = anotherDog.havePuppy(name: "tommy")


let animal1 = Animal.makeAndName()
let animal2 = Dog.makeAndName()
animal2.race

type(of:animal2)
```
