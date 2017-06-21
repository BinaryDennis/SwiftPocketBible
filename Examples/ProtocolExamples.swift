protocol Bird : CustomStringConvertible
{
    var name: String { get }
    var canFly: Bool { get }
}

extension Bird
{
    var canFly: Bool { return self is Flyable }
}

extension CustomStringConvertible where Self: Bird
{
    var description: String {
        return canFly ? "I can fly" : "Guess I’ll just sit here :["
    }
}

extension Motorcycle: Racer {}


func topSpeed<R: Sequence>(of racers: R) -> Double where R.Iterator.Element == Racer
{
    return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
}

topSpeed(of: racers[1...3])


extension Sequence where Iterator.Element == Racer
{
    func topSpeed() -> Double {
        return self.max(by:{ $0.speed < $1.speed })?.speed ?? 0
    }
}

racers[3…4].topSpeed()



protocol Score: Equatable, Comparable {
    var value: Int { get }
}

extension Score  {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }

    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
}

struct RacingScore: Score {
    let value: Int
}

RacingScore(value: 40) > RacingScore(value: 30)








protocol Printable {
    func printPdf()
}

extension Printable {
    func printPdf() {
        print("printPdf from protocol extension")
    }

    func printDoc() {  //not part of the protocol definition - hence its statically dispathced
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

let p1 : Printable = Photo()
p1.printPdf()  //printPdf from Photo
p1.printDoc()  //printDoc from protocol extension


class Chart: Printable {

}

class PieChart : Chart {
    //Note that this is not dynamically dispatched!
    //If static type is Printable or Chart, but dynamic type is PieChart
    //then printPdf() of PieChart will never be called since
    //dynamic dispatching in inheriance only works if a subclass overrides
    //a method of its super class. In this case the superclass, Chart, has
    //not explicity defined the method printPdf (although it gets the protocol
    //extensions default implementation), so the subclass PieChart cannot use
    //the reserved word 'override'.
    //To solve this, see example with Diagram and ColorDiagram
    func printPdf() {
        print("printPdf from PieChart")
    }
}

let p2 : Printable = PieChart()
p2.printPdf() //printPdf from protocol extension
p2.printDoc() //printDoc from protocol extension


class Diagram : Printable {
    func printPdf() {
        print("printPdf from Diagram")
    }
}

class ColorDiagram : Diagram {

    override func printPdf() {
        print("printPdf from ColorDiagram")
    }

    func printDoc() {
        print("printDoc from ColorDiagram")
    }
}

let p3 : Printable = ColorDiagram()
p3.printPdf()  //printPdf from ColorDiagram
p3.printDoc()  //printDoc from protocol extension

