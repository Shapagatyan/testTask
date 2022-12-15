//
//  UITabBar Extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 28.08.22.
//

import Foundation
import UIKit

extension UITabBar {
    func addBadge(value: String, index: Int) {
        if let tabItems = items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = value
            tabItem.badgeColor = UIColor(hex: "#FF6E4E")
            tabItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        }
    }

    func removeBadge(index: Int) {
        if let tabItems = items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = nil
        }
    }
}
