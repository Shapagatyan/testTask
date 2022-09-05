//
//  UITabBar Extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 28.08.22.
//

import Foundation
import UIKit
extension UITabBar {
    func setBadge(value: String?, at index: Int, withConfiguration configuration: TabBarBadgeConfiguration = TabBarBadgeConfiguration()) {
        let existingBadge = subviews.first { ($0 as? TabBarBadge)?.hasIdentifier(for: index) == true }
        existingBadge?.removeFromSuperview()

        guard let tabBarItems = items,
              let value = value else { return }

        let itemPosition = CGFloat(index + 1)
        let itemWidth = frame.width / CGFloat(tabBarItems.count)
        let itemHeight = frame.height

        let badge = TabBarBadge(for: index)
        badge.frame.size = configuration.size
        badge.center = CGPoint(x: (itemWidth * itemPosition) - (0.5 * itemWidth) + configuration.centerOffset.x,
                               y: (0.5 * itemHeight) + configuration.centerOffset.y)
        badge.layer.cornerRadius = 0.5 * configuration.size.height
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.backgroundColor = configuration.backgroundColor
        badge.font = configuration.font
        badge.textColor = configuration.textColor
        badge.text = value

        addSubview(badge)
    }
}

class TabBarBadge: UILabel {
    var identifier = String(describing: TabBarBadge.self)

    private func identifier(for index: Int) -> String {
        return "\(String(describing: TabBarBadge.self))-\(index)"
    }

    convenience init(for index: Int) {
        self.init()
        identifier = identifier(for: index)
    }

    func hasIdentifier(for index: Int) -> Bool {
        let has = identifier == identifier(for: index)
        return has
    }
}

class TabBarBadgeConfiguration {
    var backgroundColor = UIColor(hex: "#FF6E4E")
    var centerOffset: CGPoint = .init(x: 12, y: -9)
    var size: CGSize = .init(width: 17, height: 17)
    var textColor: UIColor = .white
    var font: UIFont! = .systemFont(ofSize: 11) {
        didSet { font = font ?? .systemFont(ofSize: 11) }
    }

    static func construct(_ block: (TabBarBadgeConfiguration) -> Void) -> TabBarBadgeConfiguration {
        let new = TabBarBadgeConfiguration()
        block(new)
        return new
    }
}
