//
//  HotSalesCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import UIKit

class HotSalesCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var backView: UIView!
    @IBOutlet var newLabelSuperView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var isBuyButton: UIButton!
    @IBOutlet var isNewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = backView.frame.height / 8
        newLabelSuperView.layer.cornerRadius = newLabelSuperView.frame.height / 2
        isBuyButton.layer.cornerRadius = isBuyButton.frame.height / 4
    }

    func setData(section: HomeStore) {
        titleLabel.text = section.title
        subTitleLabel.text = section.subtitle
        pictureImageView.setImage(imageURL: section.picture)
    }
}
