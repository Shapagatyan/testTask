//
//  ColorAndCapacityCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 26.08.22.
//

import UIKit

class ColorCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var backView: UIView!
    @IBOutlet var iconImage: UIImageView!

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                iconImage.image = UIImage(named: "DoneIcon")
            } else {
                iconImage.image = nil
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = 20
    }
}
