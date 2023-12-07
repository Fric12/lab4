import Foundation

let concurrentQueue = OperationQueue()
let balanceAccessQueue = OperationQueue()

var accountBalance = 1000

func withdraw(amount: Int) {
    balanceAccessQueue.addOperation {
        concurrentQueue.addOperation {
            if accountBalance > amount {
                // Simulate delay for demonstration purposes
                Thread.sleep(forTimeInterval: 1)
                accountBalance -= amount
                print("Successful withdrawal. Remaining balance: \(accountBalance)")
            } else {
                print("Insufficient funds")
            }
        }
    }
}

func refillBalance(amount: Int) {
    balanceAccessQueue.addOperation {
        concurrentQueue.addOperation {
            // Simulate delay for demonstration purposes
            Thread.sleep(forTimeInterval: 1)
            accountBalance += amount
            print("Successful refill. Remaining balance: \(accountBalance)")
        }
    }
}

for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}
