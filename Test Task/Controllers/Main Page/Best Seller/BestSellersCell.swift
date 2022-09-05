//
//  BestSellersCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import UIKit

class BestSellersCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var backView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var isLikedButton: UIButton!
    @IBOutlet var discountPriceLabel: UILabel!
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var priceWithoutDiscountLabel: UILabel!

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - SetupUI
extension BestSellersCell {
    func setupUI() {
        isLikedButton.setShadow()
        backView.layer.cornerRadius = 10
        isLikedButton.layer.cornerRadius = isLikedButton.frame.height / 2
    }
}

// MARK: - Actions
extension BestSellersCell {
    func setData(section: BestSeller) {
        titleLabel.text = section.title
        pictureImageView.setImage(imageURL: section.picture)
        discountPriceLabel.text = "$" + String(section.discountPrice)
        if section.isFavorites {
            isLikedButton.setImage(UIImage(named: "likeImageFillpng"), for: .selected)
        } else {
            isLikedButton.setImage(UIImage(named: "likeImageEmpty"), for: .normal)
        }

        let attributeString = NSMutableAttributedString(string: "$" + String(section.priceWithoutDiscount))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        priceWithoutDiscountLabel.attributedText = attributeString
    }
}
