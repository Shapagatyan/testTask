//
//  UIButton extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Foundation
import UIKit

extension UINavigationItem {
    func setLeftBarButtonItem(caller: UIViewController, color: UIColor, icon: String, action: Selector) {
        let leftButton: UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 5
            button.backgroundColor = color
            button.setImage(UIImage(named: icon), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
            button.addTarget(caller, action: action, for: .touchUpInside)
            return button
        }()

        self.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }

    func setRightBarButtonItem(caller: UIViewController, color: UIColor, icon: String, action: Selector) {
        let rightButton: UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 5
            button.backgroundColor = color
            button.setImage(UIImage(named: icon), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
            button.addTarget(caller, action: action, for: .touchUpInside)
            return button
        }()

        self.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
}
