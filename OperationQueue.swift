import Foundation

let concurrentQueue = OperationQueue()
var accountBalance = 1000

func withdraw(amount: Int) {
  concurrentQueue.addOperation {
    balanceQueue.sync {
      if accountBalance >= amount { // Simulate delay for demonstration purposes
        //Thread.sleep(forTimeInterval: 1)
        accountBalance -= amount
        print("Withdrawal successful. Remaining balance: \(accountBalance)")
      } else {
        print("Insufficient funds")
      }
    }
  }
}

func refillBalance(amount: Int) {
  concurrentQueue.addOperation {
    balanceQueue.sync {
      // Simulate delay for demonstration purposes
      //Thread.sleep(forTimeInterval: 1)
      accountBalance += amount
      print("Refill successful. Remaining balance: \(accountBalance)")
    }
  }
}

// Simulate multiple withdrawals happening concurrentl
for _ in 1...5 {
  withdraw(amount: 150)
  refillBalance(amount: 200)
}
