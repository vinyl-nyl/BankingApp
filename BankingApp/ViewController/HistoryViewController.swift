//
//  HistoryViewController.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? 
            UIColor.systemBackground : UIColor.systemGroupedBackground
        }
        
        titleLabel.text = "History"
        titleLabel.textColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
    }
}
