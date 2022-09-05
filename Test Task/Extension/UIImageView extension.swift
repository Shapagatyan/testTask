//
//  UIImage extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(imageURL: String) {
        kf.setImage(with: URL(string: imageURL))
    }
}
