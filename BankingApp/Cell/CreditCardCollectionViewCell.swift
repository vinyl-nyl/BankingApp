//
//  CreditCardCollectionViewCell.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

class CreditCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var holderNameLabel: UILabel!
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 12
        cardView.layer.shadowOpacity = 0.2
    }

    func configure(with card: CreditCard) {
        cardView.backgroundColor = card.color
        holderNameLabel.text = card.holderName
        holderNameLabel.textColor = .white
        holderNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        cardTypeImageView.image = UIImage(systemName: card.cardType.logoName)
        cardTypeImageView.tintColor = .white

        availableBalanceLabel.text = "Available balance"
        availableBalanceLabel.textColor = .white.withAlphaComponent(0.8)
        availableBalanceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        balanceAmountLabel.text = card.availableBalance.formattedAsCurrency
        balanceAmountLabel.textColor = .white
        balanceAmountLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)

        cardNumberLabel.text = "Card Code ····\(card.cardNumber)"
        cardNumberLabel.textColor = .white.withAlphaComponent(0.8)
        cardNumberLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
