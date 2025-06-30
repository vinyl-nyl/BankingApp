//
//  ActivityTransactionTableViewCell.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

class ActivityTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        iconImageView.layer.cornerRadius = 22
        iconImageView.backgroundColor = UIColor.systemGray6
        iconImageView.tintColor = .systemGray
    }

    func configure(with transaction: Transaction) {
        iconImageView.image = UIImage(systemName: transaction.iconName)
        iconImageView.backgroundColor = transaction.category.color.withAlphaComponent(0.2)
        iconImageView.tintColor = transaction.category.color

        titleLabel.text = transaction.title
        titleLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        timeLabel.text = "Today, \(transaction.date.timeString)"
        timeLabel.textColor = .systemGray
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        let isPositive = transaction.amount > 0
        amountLabel.text = "\(isPositive ? "+" : "")\(transaction.amount.formattedAsCurrency)"
        amountLabel.textColor = isPositive ? .systemGreen : .label
        amountLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        dateLabel.text = transaction.date.dateString
        dateLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}
