import Foundation

struct ValueAccount {
    var balance: Int
    
    func depositing(amount: Int) -> ValueAccount {
        var copy = self
        copy.deposit(amount: amount)
        return copy
    }
    
    mutating func deposit(amount: Int) {
        balance += amount
    }
    
    mutating func transfer(amount: Int, from: inout ValueAccount) {
        balance += amount
        from.balance -= amount
    }
}

func deposit(amount: Int, into account: inout ValueAccount) {
    account.balance += amount
}


var account = ValueAccount(balance: 0)
let other = account
deposit(amount: 10, into: &account)
account.balance
other.balance


class ClassAccount {
    var balance: Int
    
    init(balance: Int) {
        self.balance = balance
    }
    
    func deposit(amount: Int) {
        balance += amount
    }
}

// MARK - Collections in Swift are value types if the containing elements are values types
var account1 = ValueAccount(balance: 1)
var account2 = ValueAccount(balance: 2)

let allValueAccounts = [account1, account2]

// This is actually copying the collection since the elements are value types [copy-on-write]
// copyValueAccounts is now a mutable (declared as var) value type Collection
var copyValueAccounts = allValueAccounts
copyValueAccounts[0].deposit(amount: 40)
allValueAccounts[0].balance //balance is still 1
account1.balance //balance is still 1

//Since its declated as var the Collection is obviosuly mutable
copyValueAccounts[0] = ValueAccount(balance: 7)
copyValueAccounts[0].balance //balance is 7

// MARK - Collections in Swift are reference type if the containing elements are reference types
var account4 = ClassAccount(balance: 4)
var account5 = ClassAccount(balance: 5)

let allClassAccounts = [account4, account5]

// This is just creating a pointer to the other collection (no copy is done since the elements are reference types)
let copyClassAccounts = allClassAccounts
copyClassAccounts[0].deposit(amount: 40)
allClassAccounts[0].balance //balance is 44
account4.balance //balance is 44

// cannot change the Collection since its declared as immutable (i.e. let)
//copyValueAccounts[0] = ClassAccount(balance: 7)  //error!



// MARK: - SUMMARY
// 1. immutable collection of value types
//    a. value types with mutating behaviour      -> can NOT change any element in the Collection
//    b. value types with no mutating behaviour   -> can NOT change any element in the Collection
// 2. mutable collection of value types
//    a. value types with mutating behaviour      -> CAN change any element in the Collection
//    b. value types with no mutating behaviour   -> can NOT change any element in the Collection

