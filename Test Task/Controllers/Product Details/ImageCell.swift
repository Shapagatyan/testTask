//
//  ImageCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import CollectionViewPagingLayout
import UIKit

class ImageCell: UICollectionViewCell {
    // MARK: - Views
    lazy var cardView: CardView = {
        let view = CardView(frame: .zero)
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension ImageCell {
    func setupUI() {
        addCardView()
        layer.cornerRadius = 20
        contentView.backgroundColor = .clear
    }

    func addCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        cardView.pinCenterToSuperView()
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            cardView.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.66),
        ])
    }
}

extension ImageCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        return ScaleTransformViewOptions(minScale: 0.7, scaleRatio: 0.5, translationRatio: CGPoint(x: 0.6, y: 0.5), maxTranslationRatio: CGPoint(x: 2, y: 0))
    }
}
