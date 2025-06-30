//
//  Model.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

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
