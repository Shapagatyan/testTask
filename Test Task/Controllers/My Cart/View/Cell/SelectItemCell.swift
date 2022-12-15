//
//  ChangedItemCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Kingfisher
import RealmSwift
import UIKit

protocol SelectItemCellDelegate: NSObjectProtocol {
    func productCellPlusAction(_ product: BasketProduct)
    func productCellMinusAction(_ product: BasketProduct)
    func productCellDeleteAction(_ product: BasketProduct)
}

class SelectItemCell: UITableViewCell {
    // MARK: - Views
    @IBOutlet var backVew: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var itemDeleteButton: UIButton!
    @IBOutlet var itemsImageView: UIImageView!

    // MARK: - Properties
    weak var delegate: SelectItemCellDelegate?
    private var product: BasketProduct?

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - setupUI
    func setupUI() {
        backVew.layer.cornerRadius = 10
        itemsImageView.layer.cornerRadius = 6
        selectionStyle = UITableViewCell.SelectionStyle.none
    }

    // MARK: - Actions
    func setData(item: BasketProduct) {
        product = item
        nameLabel.text = item.product.title
        priceLabel.text = "$ " + String(item.product.price) + ".00"
        itemsImageView.setImage(imageURL: item.product.images)
        countLabel.text = "\(item.count)"
    }

    @IBAction func plusTappedAction(_ sender: UIButton) {
        guard let product = product else { return }
        delegate?.productCellPlusAction(product)
    }

    @IBAction func minusTappedAction(_ sender: Any) {
        guard let product = product else { return }
        delegate?.productCellMinusAction(product)
    }

    @IBAction func deleteAction(_ sender: UIButton) {
        guard let product = product else { return }
        delegate?.productCellDeleteAction(product)
    }
}
