# Swift Thread Safety


Thread safety basically means ensuring that a given object can be accessed from different threads "at the same time" without it causing any problems.

For example, a Singelton should make sure that any mutable data it has which is read and written to by other objects (i.e shared data), is protected so that a given object cannot write to the shared mutable data while another object is reading from the same shared data.

There are a few ways of protecting shared data, i.e. making it thread safe.


1. Dispatch barriers

```swift
final class Messenger {

    private var messages: [String] = []

    private var queue = DispatchQueue(label: "messages.queue", attributes: .concurrent)

    var lastMessage: String? {
        return queue.sync {
            messages.last
        }
    }

    func postMessage(_ newMessage: String) {
        queue.sync(flags: .barrier) {
            messages.append(newMessage)
        }
    }
}

let messenger = Messenger()
// Executed on Thread #1
messenger.postMessage("Hello SwiftLee!")
// Executed on Thread #2
print(messenger.lastMessage) // Prints: Hello SwiftLee!
```

2. Semaphores

To avoid thread starvation and thread prio inversion, its a good idea to use semaphores among threads of the same priority.

```swift
let semaphore = DispatchSemaphore(value: 1) //value indicates number of threads allowed to access the shared resource at the same time

//request the semaphore, ie lock
 semaphore.wait() //blocks the thread if the resouces is not available
 
 //release the semaphore, ie unlock
 semaphore.signal() 

```

Playground example
```swift
import Foundation
import PlaygroundSupport

let higherPriority = DispatchQueue.global(qos: .userInitiated)
let lowerPriority = DispatchQueue.global(qos: .utility)


let semaphore = DispatchSemaphore(value: 1)

func asyncPrint(queue: DispatchQueue, symbol: String) {
    queue.async {
        print("\(symbol) waiting")
        semaphore.wait()  // requesting the resource

        for i in 0...10 {
            print(symbol, i)
        }

        print("\(symbol) signal")
        semaphore.signal() // releasing the resource
    }
}

asyncPrint(queue: higherPriority, symbol: "🔴")
asyncPrint(queue: lowerPriority, symbol: "🔵")

PlaygroundPage.current.needsIndefiniteExecution = true
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
5. Single-queue

An easy, but perhaps not architectually robust, way of achieving thread safety is to make sure all access to the shared resource comes from the same thread. Perhaps not the main thread to prevent blocking the UI.



