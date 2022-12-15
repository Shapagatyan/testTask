//
//  HotSalesCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import UIKit

class HotSaleCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet private var backView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var isNewLabel: UILabel!
    @IBOutlet private var isBuyButton: UIButton!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var newLabelSuperView: UIView!
    @IBOutlet private var pictureImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = backView.frame.height / 8
        isBuyButton.layer.cornerRadius = isBuyButton.frame.height / 4
        newLabelSuperView.layer.cornerRadius = newLabelSuperView.frame.height / 2
    }

    func setData(item: HomeStore) {
        titleLabel.text = item.title
        subTitleLabel.text = item.subtitle
        pictureImageView.setImage(imageURL: item.picture)
    }
}
