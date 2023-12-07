import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
let balanceAccessSemaphore = DispatchSemaphore(value: 1) // Початкове значення 1

var accountBalance = 1000

func withdraw(amount: Int) {
    concurrentQueue.async {
        // Очікуємо, поки семафор стане доступним
        balanceAccessSemaphore.wait()

        if accountBalance > amount {
            // Симулюємо затримку для демонстрації
            Thread.sleep(forTimeInterval: 1)
            accountBalance -= amount
            print("Успішне зняття коштів. Залишок: \(accountBalance)")
        } else {
            print("Недостатньо коштів")
        }

        // Позначаємо, що критична секція завершилася
        balanceAccessSemaphore.signal()
    }
}

func refillBalance(amount: Int) {
    concurrentQueue.async {
        // Очікуємо, поки семафор стане доступним
        balanceAccessSemaphore.wait()

        // Симулюємо затримку для демонстрації
        Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Успішне поповнення. Залишок: \(accountBalance)")

        // Позначаємо, що критична секція завершилася
        balanceAccessSemaphore.signal()
    }
}

// Симулюємо кілька виведень коштів, які відбуваються паралельно
for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}
