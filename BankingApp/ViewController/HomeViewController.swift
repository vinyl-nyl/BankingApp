//
//  HomeViewController.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var cardPageControl: UIPageControl!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var allExpenseView: UIView!
    @IBOutlet weak var allExpenseAmountLabel: UILabel!
    @IBOutlet weak var monthlyExpenseView: UIView!
    @IBOutlet weak var monthlyExpenseAmountLabel: UILabel!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - Properties
    private let dataManager = DataManager.shared
    private var creditCards: [CreditCard] = []
    private var transactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupTableView()
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
            UIColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 1.0) :
            UIColor(red: 0.35, green: 0.45, blue: 0.9, alpha: 1.0)
        }

        welcomeLabel.text = "Welcome Back"
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        nameLabel.text = "Hello Adom!"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)

        notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        notificationButton.tintColor = .white

        // Setup expense views
        setupExpenseView(allExpenseView, title: "All Expense", subtitle: "Total expense of all time")
        setupExpenseView(monthlyExpenseView, title: "Monthly Expense", subtitle: "Total expense this month only")

        allExpenseAmountLabel.text = "$\(dataManager.expenseData.totalExpense.formattedAsBalance)"
        monthlyExpenseAmountLabel.text = "$\(dataManager.expenseData.monthlyExpense.formattedAsBalance)"

        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.systemBlue, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    private func setupExpenseView(_ view: UIView, title: String, subtitle: String) {
        view.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
    }

    private func setupCollectionView() {
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.showsHorizontalScrollIndicator = false
        cardCollectionView.isPagingEnabled = true

        if let layout = cardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }

        cardPageControl.numberOfPages = dataManager.creditCards.count
        cardPageControl.currentPage = 0
        cardPageControl.pageIndicatorTintColor = .lightGray
        cardPageControl.currentPageIndicatorTintColor = .white
    }

    private func setupTableView() {
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        transactionTableView.separatorStyle = .none
        transactionTableView.backgroundColor = .clear
        transactionTableView.showsVerticalScrollIndicator = false
    }

    private func loadData() {
        creditCards = dataManager.creditCards
        transactions = Array(dataManager.transactions(for: .checking).prefix(20))

        cardCollectionView.reloadData()
        transactionTableView.reloadData()
    }

    private func updateColorsForCurrentMode() {
        // Update colors for dark/light mode
        allExpenseView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }
        monthlyExpenseView.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
            UIColor.systemGray6 : UIColor.white
        }
    }

    // MARK: - IBActions
    @IBAction func seeAllButtonTapped(_ sender: UIButton) {
        print("See all transactions tapped")
    }

    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        print("Notification button tapped")
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creditCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCardCell", for: indexPath) as! CreditCardCollectionViewCell
        let card = creditCards[indexPath.item]
        cell.configure(with: card)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 40 // 20 padding on each side
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let activityVC = storyboard.instantiateViewController(withIdentifier: "ActivityViewController") as? ActivityViewController {
            navigationController?.pushViewController(activityVC, animated: true)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == cardCollectionView {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            cardPageControl.currentPage = Int(pageIndex)
        }
    }
}

// MARK: - UITableView DataSource & Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
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
