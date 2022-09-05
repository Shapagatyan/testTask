//
//  UITableView Extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCell(cellType: UICollectionViewCell.Type) {
        self.register(UINib(nibName: cellType.name, bundle: nil), forCellWithReuseIdentifier: cellType.name)
    }
}
