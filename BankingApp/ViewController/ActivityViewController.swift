//
//  ActivityViewController.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

class ActivityViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var checkingButton: UIButton!
    @IBOutlet weak var savingsButton: UIButton!
    @IBOutlet weak var cryptoButton: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var quickActionsStackView: UIStackView!
    @IBOutlet weak var analyticsView: UIView!
    @IBOutlet weak var analyticsLabel: UILabel!
    @IBOutlet weak var analyticsDescriptionLabel: UILabel!
    @IBOutlet weak var cashbackView: UIView!
    @IBOutlet weak var cashbackLabel: UILabel!
    @IBOutlet weak var cashbackDescriptionLabel: UILabel!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - Properties
    private let dataManager = DataManager.shared
    private var currentCategory: Transaction.TransactionCategory = .checking
    private var transactions: [Transaction] = []
    private var categoryButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupCategoryButtons()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateColorsForCurrentMode()
        }
    }

    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemBackground : UIColor.systemGroupedBackground
        }

        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }

        titleLabel.text = "Activity"
        titleLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        menuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuButton.tintColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }

        // Setup indicator
        indicatorView.backgroundColor = .systemBlue
        indicatorView.layer.cornerRadius = 2

        // Setup quick actions
        setupQuickActions()

        // Setup analytics and cashback views
        setupAnalyticsView()
        setupCashbackView()

        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.systemBlue, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    private func setupCategoryButtons() {
        categoryButtons = [checkingButton, savingsButton, cryptoButton]

        checkingButton.setTitle("Checking", for: .normal)
        savingsButton.setTitle("Savings", for: .normal)
        cryptoButton.setTitle("Crypto", for: .normal)

        for (index, button) in categoryButtons.enumerated() {
            button.tag = index
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        }

        updateCategoryButtonAppearance()
    }

    private func setupQuickActions() {
        let buttonConfigs = [
            ("creditcard.fill", UIColor.systemBlue),
            ("v.circle.fill", UIColor.systemBlue),
            ("p.circle.fill", UIColor.systemBlue),
            ("plus.circle.fill", UIColor.systemBlue)
        ]

        for (imageName, color) in buttonConfigs {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: imageName), for: .normal)
            button.tintColor = color
            button.backgroundColor = UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                UIColor.systemGray6 : UIColor.white
            }
            button.layer.cornerRadius = 25
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.1

            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true

            quickActionsStackView.addArrangedSubview(button)
        }
    }

    private func setupAnalyticsView() {
        analyticsView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }
        analyticsView.layer.cornerRadius = 12
        analyticsView.layer.shadowColor = UIColor.black.cgColor
        analyticsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        analyticsView.layer.shadowRadius = 8
        analyticsView.layer.shadowOpacity = 0.1

        analyticsLabel.text = "Analytics"
        analyticsLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        analyticsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        analyticsDescriptionLabel.text = dataManager.analytics.description
        analyticsDescriptionLabel.textColor = .systemGray
        analyticsDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private func setupCashbackView() {
        cashbackView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }
        cashbackView.layer.cornerRadius = 12
        cashbackView.layer.shadowColor = UIColor.black.cgColor
        cashbackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cashbackView.layer.shadowRadius = 8
        cashbackView.layer.shadowOpacity = 0.1

        cashbackLabel.text = "Cashback"
        cashbackLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        cashbackLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        cashbackDescriptionLabel.text = dataManager.cashback.description
        cashbackDescriptionLabel.textColor = .systemGray
        cashbackDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private func setupTableView() {
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        transactionTableView.separatorStyle = .none
        transactionTableView.backgroundColor = .clear
        transactionTableView.showsVerticalScrollIndicator = false
    }

    private func loadData() {
        updateBalanceForCategory()
        transactions = Array(dataManager.transactions(for: currentCategory).prefix(20))
        transactionTableView.reloadData()
    }

    private func updateBalanceForCategory() {
        let balance = dataManager.totalBalance(for: currentCategory)
        let change = dataManager.weeklyChange(for: currentCategory)

        balanceLabel.text = balance.formattedAsCurrency
        balanceLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        balanceLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)

        changeLabel.text = "↗ \(change.amount.formattedAsCurrency) (\(String(format: "%.2f", change.percentage))%)"
        changeLabel.textColor = .systemGreen
        changeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    private func updateCategoryButtonAppearance() {
        for (index, button) in categoryButtons.enumerated() {
            let isSelected = index == currentCategory.rawValue.hashValue % 3
            button.setTitleColor(isSelected ? .systemBlue : .systemGray, for: .normal)
        }
    }

    private func animateIndicator(to index: Int) {
        let buttonWidth = categoryStackView.frame.width / 3
        let newLeadingConstant = buttonWidth * CGFloat(index)

        indicatorLeadingConstraint.constant = newLeadingConstant

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }

    private func updateColorsForCurrentMode() {
        analyticsView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }
        cashbackView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }

        // Update quick action buttons
        for case let button as UIButton in quickActionsStackView.arrangedSubviews {
            button.backgroundColor = UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                UIColor.systemGray6 : UIColor.white
            }
        }
    }

    // MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func menuButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Export Data", style: .default) { _ in
            print("Export Data selected")
        })

        alertController.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            print("Settings selected")
        })

        alertController.addAction(UIAlertAction(title: "Help & Support", style: .default) { _ in
            print("Help & Support selected")
        })

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        if let popover = alertController.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }

        present(alertController, animated: true)
    }

    @IBAction func seeAllButtonTapped(_ sender: UIButton) {
        print("See all transactions for \(currentCategory.rawValue) tapped")
    }

    @objc private func categoryButtonTapped(_ sender: UIButton) {
        let categories: [Transaction.TransactionCategory] = [.checking, .savings, .crypto]
        currentCategory = categories[sender.tag]

        updateCategoryButtonAppearance()
        animateIndicator(to: sender.tag)
        loadData()
    }
}

// MARK: - UITableView DataSource & Delegate
extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTransactionCell", for: indexPath) as! ActivityTransactionTableViewCell
        let transaction = transactions[indexPath.row]
        cell.configure(with: transaction)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
