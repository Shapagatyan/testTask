//
//  TabBarController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 28.08.22.
//

import Alamofire
import RealmSwift
import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    var bascetItems: [Product] = []
    var customTabBarView = UIView(frame: .zero)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarUI()
        self.addCustomTabBarView()
        self.getData()

        let controllers = TabBarControllerType.allCases.map { type -> UIViewController in
            let controller = UINavigationController(rootViewController: type.controller)
            controller.tabBarItem = UITabBarItem(title: "", image: type.image, tag: type.rawValue)
            return controller
        }
        setViewControllers(controllers, animated: true)
    }

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
    func getData() {
        let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")
        AF.request(url!, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(BascetItems.self, from: data)
                    self.bascetItems = items.basket
                    self.tabBar.setBadge(value: String(self.bascetItems.count), at: 1)
                } catch {
                    print("Ошибка")
                }
            case .failure:
                print("Ошибка")
            }
        }
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
