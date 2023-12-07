import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
let balanceAccessQueue = DispatchQueue(label: "com.example.balanceAccessQueue", attributes: .concurrent)

var accountBalance = 1000

func withdraw(amount: Int) {
    balanceAccessQueue.async {
        concurrentQueue.async {
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
    balanceAccessQueue.async {
        concurrentQueue.async {
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
