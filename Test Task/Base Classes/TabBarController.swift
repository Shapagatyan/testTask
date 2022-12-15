//
//  TabBarController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 28.08.22.
//

import Alamofire
import Combine
import RealmSwift
import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    var cancellable: Set<AnyCancellable> = []
    var customTabBarView = UIView(frame: .zero)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarUI()
        self.addCustomTabBarView()
        self.setupBinding()
        let controllers = TabBarControllerType.allCases.map { type -> UIViewController in
            let controller = UINavigationController(rootViewController: type.controller)
            controller.tabBarItem = UITabBarItem(title: "", image: type.image, tag: type.rawValue)
            return controller
        }
        setViewControllers(controllers, animated: true)
    }
    
    // MARK: - Layout Subviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setupCustomTabBarFrame()
    }
    
    // MARK: - Actions
    func setupTabBarUI() {
        tabBar.tintColor = .white
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = true
        tabBar.barTintColor = UIColor(hex: "#010035")
        tabBar.backgroundColor = UIColor(hex: "#010035")
        tabBar.unselectedItemTintColor = UIColor(hex: "#B3B3C3")
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupCustomTabBarFrame() {
        let height = self.view.safeAreaInsets.bottom + 20
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()
    }
    
    func addCustomTabBarView() {
        self.customTabBarView.frame = tabBar.frame
        self.customTabBarView.layer.cornerRadius = 30
        self.customTabBarView.backgroundColor = UIColor(hex: "#010035")
        self.customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.customTabBarView.layer.masksToBounds = true
        view.addSubview(self.customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    // MARK: - Request
    func setupBinding() {
        Basket.shared.$products.delay(for: 0.1, scheduler: RunLoop.main).sink { [weak self] items in
            guard let `self` = self else { return }
            self.tabBar.addBadge(value: String(items.count), index: 1)
            if items.count == 0 {
                self.tabBar.removeBadge(index: 1)
            }
        }.store(in: &self.cancellable)
    }
}
    
// MARK: - Healpers
enum TabBarControllerType: Int, CaseIterable {
    case main
    case buscet
    case faviorite
    case profile

    var controller: UIViewController {
        switch self {
        case .main:
            return MainViewController()
        case .buscet:
            return MyCardController()
        case .faviorite:
            return MainViewController()
        case .profile:
            return MainViewController()
        }
    }

    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "ExplorerTB")
        case .buscet:
            return UIImage(named: "BuscetTB")
        case .faviorite:
            return UIImage(named: "HeartTB")
        case .profile:
            return UIImage(named: "ProfileTB")
        }
    }
}
