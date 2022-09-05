//
//  NSLayoutConstraint extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import UIKit

extension UIView {
    func addRatioConstraint() {
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0).isActive = true
    }
}
