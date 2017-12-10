import Foundation

struct Account {
    var balance: Int
    
    func depositing(amount: Int) -> Account {
        var copy = self
        copy.deposit(amount: amount)
        return copy
    }
    
    mutating func deposit(amount: Int) {
        balance += amount
    }
    
    // inout is similar to mutating self (it mutates a local copy and returns that copy)
    mutating func transfer(amount: Int, from: inout Account) {
        balance += amount
        from.balance -= amount
    }
}

func deposit(amount: Int, into account: inout Account) {
    account.balance += amount
}

var account = Account(balance: 0)
let other = account
deposit(amount: 10, into: &account)
account.balance
other.balance


