//
//  Model.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import Foundation
import UIKit

// MARK: - Data Models
struct CreditCard {
    let id: String
    let holderName: String
    let cardNumber: String
    let availableBalance: Double
    let cardType: CardType
    let color: UIColor

    enum CardType {
        case visa
        case mastercard
        case paypal

        var logoName: String {
            switch self {
            case .visa: return "creditcard.fill"
            case .mastercard: return "creditcard.circle"
            case .paypal: return "p.circle.fill"
            }
        }
    }
}

struct Transaction {
    let id: String
    let title: String
    let amount: Double
    let date: Date
    let category: TransactionCategory
    let iconName: String

    enum TransactionCategory: String, CaseIterable {
        case checking = "Checking"
        case savings = "Savings"
        case crypto = "Crypto"

        var color: UIColor {
            switch self {
            case .checking: return .systemBlue
            case .savings: return .systemGreen
            case .crypto: return .systemOrange
            }
        }
    }
}

struct ExpenseData {
    let totalExpense: Double
    let monthlyExpense: Double
}

struct Analytics {
    let description: String
    let amount: Double
}

struct Cashback {
    let description: String
    let amount: Double
}

// MARK: - Data Manager
class DataManager {
    static let shared = DataManager()
    private init() {}

    // Sample Credit Cards
    lazy var creditCards: [CreditCard] = [
        CreditCard(
            id: "1",
            holderName: "Adom Shafi",
            cardNumber: "9658",
            availableBalance: 8300.90,
            cardType: .visa,
            color: UIColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 1.0)
        ),
        CreditCard(
            id: "2",
            holderName: "Adom Shafi",
            cardNumber: "4521",
            availableBalance: 12450.75,
            cardType: .mastercard,
            color: UIColor(red: 0.8, green: 0.2, blue: 0.4, alpha: 1.0)
        ),
        CreditCard(
            id: "3",
            holderName: "Adom Shafi",
            cardNumber: "7890",
            availableBalance: 5670.30,
            cardType: .paypal,
            color: UIColor(red: 0.4, green: 0.8, blue: 0.2, alpha: 1.0)
        )
    ]

    // Sample Transactions
    lazy var transactions: [Transaction] = [
        Transaction(id: "1", title: "Netflix", amount: 120, date: Date(), category: .checking, iconName: "tv.fill"),
        Transaction(id: "2", title: "Tony Stark", amount: -950, date: Date().addingTimeInterval(-3600), category: .checking, iconName: "person.crop.circle.fill"),
        Transaction(id: "3", title: "Mike William", amount: -856, date: Date().addingTimeInterval(-7200), category: .checking, iconName: "person.crop.circle.fill"),
        Transaction(id: "4", title: "Spotify", amount: 15.99, date: Date().addingTimeInterval(-10800), category: .checking, iconName: "music.note"),
        Transaction(id: "5", title: "Amazon", amount: -234.50, date: Date().addingTimeInterval(-14400), category: .checking, iconName: "bag.fill"),
        Transaction(id: "6", title: "Apple Store", amount: -1299, date: Date().addingTimeInterval(-18000), category: .checking, iconName: "applelogo"),
        Transaction(id: "7", title: "Starbucks", amount: -8.75, date: Date().addingTimeInterval(-21600), category: .checking, iconName: "cup.and.saucer.fill"),
        Transaction(id: "8", title: "Uber", amount: -23.40, date: Date().addingTimeInterval(-25200), category: .checking, iconName: "car.fill"),
        Transaction(id: "9", title: "McDonald's", amount: -12.99, date: Date().addingTimeInterval(-28800), category: .checking, iconName: "fork.knife"),
        Transaction(id: "10", title: "Gas Station", amount: -67.80, date: Date().addingTimeInterval(-32400), category: .checking, iconName: "fuelpump.fill"),
        Transaction(id: "11", title: "Grocery Store", amount: -156.23, date: Date().addingTimeInterval(-36000), category: .checking, iconName: "cart.fill"),
        Transaction(id: "12", title: "Gym Membership", amount: -89, date: Date().addingTimeInterval(-39600), category: .checking, iconName: "figure.walk"),
        Transaction(id: "13", title: "Movie Theater", amount: -45.50, date: Date().addingTimeInterval(-43200), category: .checking, iconName: "film.fill"),
        Transaction(id: "14", title: "Book Store", amount: -28.99, date: Date().addingTimeInterval(-46800), category: .checking, iconName: "book.fill"),
        Transaction(id: "15", title: "Pharmacy", amount: -34.75, date: Date().addingTimeInterval(-50400), category: .checking, iconName: "cross.fill"),
        Transaction(id: "16", title: "Restaurant", amount: -89.20, date: Date().addingTimeInterval(-54000), category: .checking, iconName: "fork.knife"),
        Transaction(id: "17", title: "Hotel Booking", amount: -320, date: Date().addingTimeInterval(-57600), category: .checking, iconName: "bed.double.fill"),
        Transaction(id: "18", title: "Online Shopping", amount: -145.99, date: Date().addingTimeInterval(-61200), category: .checking, iconName: "bag.fill"),
        Transaction(id: "19", title: "Coffee Shop", amount: -6.50, date: Date().addingTimeInterval(-64800), category: .checking, iconName: "cup.and.saucer.fill"),
        Transaction(id: "20", title: "Salary Deposit", amount: 5000, date: Date().addingTimeInterval(-68400), category: .checking, iconName: "dollarsign.circle.fill"),

        // Savings Transactions
        Transaction(id: "21", title: "Emergency Fund", amount: 1000, date: Date(), category: .savings, iconName: "shield.fill"),
        Transaction(id: "22", title: "Vacation Fund", amount: 500, date: Date().addingTimeInterval(-3600), category: .savings, iconName: "airplane"),
        Transaction(id: "23", title: "Car Fund", amount: 750, date: Date().addingTimeInterval(-7200), category: .savings, iconName: "car.fill"),
        Transaction(id: "24", title: "House Down Payment", amount: 2000, date: Date().addingTimeInterval(-10800), category: .savings, iconName: "house.fill"),
        Transaction(id: "25", title: "Investment Transfer", amount: -500, date: Date().addingTimeInterval(-14400), category: .savings, iconName: "arrow.up.circle.fill"),

        // Crypto Transactions
        Transaction(id: "26", title: "Bitcoin Purchase", amount: -2500, date: Date(), category: .crypto, iconName: "bitcoinsign.circle.fill"),
        Transaction(id: "27", title: "Ethereum Purchase", amount: -1200, date: Date().addingTimeInterval(-3600), category: .crypto, iconName: "e.circle.fill"),
        Transaction(id: "28", title: "Dogecoin Sale", amount: 890, date: Date().addingTimeInterval(-7200), category: .crypto, iconName: "d.circle.fill"),
        Transaction(id: "29", title: "Cardano Purchase", amount: -650, date: Date().addingTimeInterval(-10800), category: .crypto, iconName: "c.circle.fill"),
        Transaction(id: "30", title: "Solana Purchase", amount: -800, date: Date().addingTimeInterval(-14400), category: .crypto, iconName: "s.circle.fill")
    ]

    let expenseData = ExpenseData(totalExpense: 60.692, monthlyExpense: 7.692)

    let analytics = Analytics(description: "Spent $500 less than last month", amount: 500)

    let cashback = Cashback(description: "$600 in June and last month 12,000", amount: 600)

    // Helper methods
    func transactions(for category: Transaction.TransactionCategory) -> [Transaction] {
        return transactions.filter { $0.category == category }
    }

    func totalBalance(for category: Transaction.TransactionCategory) -> Double {
        let categoryTransactions = transactions(for: category)
        return categoryTransactions.reduce(0) { $0 + $1.amount }
    }

    func weeklyChange(for category: Transaction.TransactionCategory) -> (amount: Double, percentage: Double) {
        // Simplified calculation for demo
        let total = totalBalance(for: category)
        let change = total * 0.0256 // 2.56% as shown in UI
        return (change, 2.56)
    }
}

// MARK: - Extensions
extension Double {
    var formattedAsCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }

    var formattedAsBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
}

extension Date {
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        return formatter.string(from: self)
    }
}
