//
//  CapacityCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 26.08.22.
//

import UIKit

class CapacityCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var backView: UIView!
    @IBOutlet var capacityLabel: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.backgroundColor = UIColor(hex: "#FF6E4E")
                capacityLabel.textColor = UIColor(hex: "#FFFFFF")
            } else {
                backView.backgroundColor = .clear
                capacityLabel.textColor = UIColor(hex: "#8D8D8D")
            }
        }
    }

    // MARK: - SetupUI
    func setupUI() {
        backView.layer.cornerRadius = 5
    }
}
