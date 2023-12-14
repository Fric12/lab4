import Foundation

let dispatchSemaphore = DispatchSemaphore(value: 1)
var accountBalance = 1000

func withdraw(amount: Int) {
    dispatchSemaphore.wait()
    defer{
        dispatchSemaphore.signal()
    }
        if accountBalance >= amount {
            //Thread.sleep(forTimeInterval: 1)
            accountBalance -= amount
            print("Withdrawal successful. Remaining balance: \(accountBalance)")
        } else {
            print("Insufficient funds")
        }
}

func refillBalance(amount: Int) {
    dispatchSemaphore.wait()
    defer{
        dispatchSemaphore.signal()
    }
        //Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Refill successful. Remaining balance: \(accountBalance)")
}

// Simulate multiple withdrawals happening concurrently
for _ in 1...5 {
  withdraw(amount: 150)
  refillBalance(amount: 200)
}
