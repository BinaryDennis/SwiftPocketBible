# Swift Thread Safety


Thread safety basically means ensuring that a given object can be accessed from different threads "at the same time" without it causing any problems.

For example, a Singelton should make sure that any mutable data it has which is read and written to by other objects (i.e shared data), is protected so that a given object cannot write to the shared mutable data while another object is reading from the same shared data.

There are a few ways of protecting shared data, i.e. making it thread safe.


1. Dispatch barriers

```swift
struct NespressoCoffeMachineSingelton {
    private var soldInCountries = ["Sweden", "Italy", "Germany"]
    let myDispatchQueue = DispatchQueue(label: "soldInCountriesQueueName", attributes: .concurrent) //Thread-safety

    var soldIn : [String] {
        let result = myDispatchQueue.sync { //Thread-safety
            return soldInCountries  
            }
        return result
    }

    func addCountry(country: String) {
        myDispatchQueue.async(flags: .barrier) { //Thread-safety
           self.soldInCountries.append(country) 
        }
    }
}
```

2. Semaphores

```swift

```

3. Global constants

```swift

let coffeBeanTypes = ["Arabica", "Robusta"]   //Thread-safe  (and lazy loaded)

class NespressoCoffeMachineSingelton {
  // bla bla bla...
}

```

4. Static Type properties

```swift
struct NespressoCoffeMachineSingelton {
    
    static let sharedInstance = NespressoCoffeMachineSingelton()   //Thread-safe  (and lazy loaded)

    //private initializer guarantees that there is only one way 
    //to create this struct, by using the sharedInstance property
    private init() {}
    
    private var soldInCountries = ["Sweden", "Italy", "Germany"]
    let myDispatchQueue = DispatchQueue(label: "soldInCountriesQueueName", attributes: .concurrent)

    var soldIn : [String] {
        let result = myDispatchQueue.sync {
            return soldInCountries  //Thread-safe
            }
        return result
    }

    func addCountry(country: String) {
        myDispatchQueue.async(flags: .barrier) {
           self.soldInCountries.append(country) //Thread-safe
        }
    }
}

```
5. obj_sync 



```swift

```
