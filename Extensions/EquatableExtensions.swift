extension Equatable {
    func isAny(of candidates: Self...) -> Bool {
        return candidates.contains(self)
    }
}

/*
enum Direction: Equatable {
    case left, right, up, down
}

let myDirection = Direction.left
myDirection.isAny(of: .up, .down, .left)

*/
