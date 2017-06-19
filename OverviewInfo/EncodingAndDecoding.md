# Encoding and decoding

`Codable` is a protocol a type can conform to for easy encoding and decoding (serialization and deserialization). If a type implements `Codable`, and all it's properties also implement `Codable` (Foundation types typically do), the Swift compiler will automatically implement the protocol without any extra work required.

### :warning: Note: Codable is only available in Swift 4.0 and later

```swift
struct Person: Codable {
  let givenName: String
  let surname: String
  let gender: Gender
    
  enum Gender: String, Codable {
    case male
    case female
  }
}
```

Other nifty stuff includes:

* Automatic handling of optional values
* Support for custom serialization

### Decoding a Person from JSON

```swift
let json = """
{
  "givenName": "Donald",
  "surname": "Duck",
  "gender": "male"
}
"""

if let person = try? JSONDecoder().decode(Person.self, from: json.data(using: .utf8)!) {
    print(person.givenName) // Donald
    print(person.surname) // Duck
    print(person.gender) // male
}
```

### Encoding a Person to JSON

```swift
let person = Person(givenName: "Donald", surname: "Duck", gender: .male)

if let data = try? JSONEncoder().encode(person),
    let json = String(data: data, encoding: .utf8) {
    print(json) // {"surname":"Duck","givenName":"Donald","gender":"male"}
}
```

### Encodable and Decodable

The definition of `Codable` looks like this:

```swift
public typealias Codable = Decodable & Encodable
```

`Codable` consists of two protocols: `Decodable` and `Encodable`. By conforming to `Codable`, the type will be both encodable and decodable. If specific support for only encoding or decoding is needed, conforming to either `Encodable` or `Decodable` may make more sense than conforming to `Codable`.

### Custom serialization

To be added.
