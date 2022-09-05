//
//  UIView extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import Foundation
import UIKit

extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor(hex: "#000000").cgColor
        self.layer.shadowOpacity = 0.2

        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 2

        self.layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func pinEdgesToSuperView(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -right)
        ])
    }

    func pinCenterToSuperView(xInset: CGFloat = 0, yInset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: xInset),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: yInset)
        ])
    }
}
