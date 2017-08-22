import Foundation

extension Collection {
    public subscript (safe index: Index?) -> Iterator.Element? {
        guard let index = index else {
            return nil
        }

        return (startIndex..<endIndex).contains(index) ? self[index] : nil
    }
}

extension Collection where Iterator.Element : Equatable {
    
    public func indexesOf(predicate: (Iterator.Element) -> Bool) -> [Index] {
        let x: [Iterator.Element] = self.filter(predicate)
        let y: [Index?] = x.map { index(of: $0) }
        return y.filter { $0 != nil }.map { $0! }
    }
    
}

extension MutableCollection {
    public subscript (safe index: Index?) -> Iterator.Element? {
        guard let index = index else {
            return nil
        }

        return (startIndex..<endIndex).contains(index) ? self[index] : nil
    }
}

extension Collection where Iterator.Element : CustomStringConvertible {

    public func implode(with separator: String = ",") -> String {
        return self.reduce("") { (result, elem) -> String in
            if result == "" {
                return result.appending(elem.description)
            } else {
                return result.appending(separator + " " + elem.description)
            }
        }
    }
}
