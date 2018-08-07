## Collections, value or reference type?
In Swift, Array, String, and Dictionary are all **value** types

## Mutability
### Mutable Instances: var
*Reference types*

The reference can be changed (mutable): you can mutate the instance itself and also change the instance reference.

*Value types*

The instance can be changed (mutable): you can change the properties of the instance

*Collections of value types*

Elements with mutating behaviour: **CAN** change any element in the Collection

Elements without mutating behaviour: **CAN'T** change any element in the Collection


### Immutable Instances: let
*Reference types*

The reference remains constant (immutable): you can’t change the instance reference, but you can mutate the instance itself.

*Value types*

The instance remains constant (immutable): you can’t change the properties of the instance, regardless whether a property is declared with let or var.


## Inout
Parameters with `inout` prefix, is similar to mutating of self in a Struct. I.e the parameter is first copied, then mutated and finally returned back to the call-site. The parameter is only mutated inside the function scope, thus it will not have any side-effect outside of the function is specified in. See example below.


## Example

```swift
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
    
    //Parameters with `inout` prefix, is similar to mutating of self in a Struct.
    //The input parameter will be copied, mutated (only in the scope of this function) and returned back to callee
    mutating func transfer(amount: Int, from: inout ValueAccount) {. 
        balance += amount
        from.balance -= amount
    }
}

func deposit(amount: Int, into account: inout ValueAccount) {
    account.balance += amount
}


var account = ValueAccount(balance: 0)
let other = account

deposit(amount: 10, into: &account)  //this is NOT passing a reference to the variable account!
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

// MARK: - Collections in Swift are value types if the containing elements are values types
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

// MARK: - Collections in Swift are reference type if the containing elements are reference types
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

```
