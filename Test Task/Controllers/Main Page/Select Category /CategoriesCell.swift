//
//  CategoriesCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var ellipseView: UIView!
    @IBOutlet var categoriesNameLabel: UILabel!
    @IBOutlet var categoriesImageView: UIImageView!

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        ellipseView.layer.cornerRadius = ellipseView.frame.height / 2
        categoriesNameLabel.textColor = UIColor(hex: "#010035")
        categoriesImageView.tintColor = UIColor(hex: "#B3B3C3")
        ellipseView.backgroundColor = UIColor(hex: "#FFFFFF")
    }

    // MARK: - Actions
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoriesNameLabel.textColor = UIColor(hex: "#FF6E4E")
                categoriesImageView.tintColor = UIColor(hex: "#FFFFFF")
                ellipseView.backgroundColor = UIColor(hex: "#FF6E4E")
            } else {
                categoriesNameLabel.textColor = UIColor(hex: "#010035")
                categoriesImageView.tintColor = UIColor(hex: "#B3B3C3")
                ellipseView.backgroundColor = UIColor(hex: "#FFFFFF")
            }
        }
    }

    func cellConfiguration(_ type: Categories) {
        categoriesNameLabel.text = type.name
        categoriesImageView.image = type.image
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.subviews.first?.layoutIfNeeded()
        ellipseView.layer.cornerRadius = ellipseView.frame.height / 2
    }
}
