extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self = URL(string: "\(value)").require()
    }
}

extension Optional {
    func require() -> Wrapped {
        guard let unwrapped = self else {
            preconditionFailure()
        }
        return unwrapped
    }
}
