// MUCH MORE WILL BE ADDED HERE, ALONG WITH EXPLANATIONS

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
