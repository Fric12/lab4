import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
let balanceAccessSemaphore = DispatchSemaphore(value: 1) // Початкове значення 1

var accountBalance = 1000

func withdraw(amount: Int) {
    concurrentQueue.async {
        balanceAccessSemaphore.wait()

        if accountBalance > amount {
            Thread.sleep(forTimeInterval: 1)
            accountBalance -= amount
            print("Successful withdrawal. Remaining balance: \(accountBalance)")
        } else {
            print("Insufficient funds")
        }

        balanceAccessSemaphore.signal()
    }
}

func refillBalance(amount: Int) {
    concurrentQueue.async {
        balanceAccessSemaphore.wait()

        Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Successful refill. Remaining balance: \(accountBalance)")

        balanceAccessSemaphore.signal()
    }
}

for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}
