//
//  MainTabBarController.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import UIKit

// MARK: - Custom Tab Bar Controller
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? 
            UIColor.systemGray6 : UIColor.white
        }
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        
        // Add shadow
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowOpacity = 0.1
        
        // Setup tab bar items
        if let viewControllers = viewControllers {
            let tabBarItems = [
                ("house.fill", "Home"),
                ("bag.fill", "Wallet"),
                ("chart.bar.fill", "History"),
                ("person.fill", "Profile")
            ]
            
            for (index, (imageName, title)) in tabBarItems.enumerated() {
                if index < viewControllers.count {
                    viewControllers[index].tabBarItem = UITabBarItem(
                        title: title,
                        image: UIImage(systemName: imageName.replacingOccurrences(of: ".fill", with: "")),
                        selectedImage: UIImage(systemName: imageName)
                    )
                }
            }
        }
    }
}
