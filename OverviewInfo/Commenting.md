# How to comment swift files

## Basic markup

```swift

/**
    # Lists

    You can apply *italic*, **bold**, or `code` inline styles.

    ## Unordered Lists

    - Lists are great,
    - but perhaps don't nest
    - Sub-list formatting

      - isn't the best.

    ## Ordered Lists

    1. Ordered lists, too
    2. for things that are sorted;
    3. Arabic numerals
    4. are the only kind supported.
*/

```


## Parameters & Return functions

```swift
/**
    Repeats a string `times` times.

    - Parameter str:   The string to repeat.
    - Parameter times: The number of times to repeat `str`.

    - Throws: `MyError.InvalidTimes` if the `times` parameter 
        is less than zero.

    - Returns: A new string with `str` repeated `times` times.
*/
func repeatString(str: String, times: Int) throws -> String {
    guard times >= 0 else { throw MyError.InvalidTimes }
    return Repeat(count: 5, repeatedValue: "Hello").joinWithSeparator("")
}

// You can reference either the external or internal parameter label, it doesnt matter which:

/**
*   - parameter string: A string
*/
func doSomething(with string: String) {}

/**
*   - parameter with: A string
*/
func doSomething(with string: String) {}



/// Returns the magnitude of a vector in three dimensions
/// from the given components.
///
/// - Parameters:
///     - x: The *x* component of the vector.
///     - y: The *y* component of the vector.
///     - z: The *z* component of the vector.
func magnitude3D(x: Double, y: Double, z: Double) -> Double {
    return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
}
```

## Descriptions fields
```swift
/**
    The area of the `Shape` instance.

    Computation depends on the shape of the instance. 
    For a triangle, `area` will be equivalent to:

        let height = triangle.calculateHeight()
        let area = triangle.base * height / 2
*/
var area: CGFloat { get }


/**
    The perimeter of the `Shape` instance.

    Computation depends on the shape of the instance, and is
    equivalent to: 

    ```
    // Circles:
    let perimeter = circle.radius * 2 * CGFloat(M_PI)

    // Other shapes:
    let perimeter = shape.sides.map { $0.length }
                               .reduce(0, combine: +)
    ```
*/
var perimeter: CGFloat { get }

```
