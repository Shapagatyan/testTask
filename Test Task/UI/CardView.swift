//
//  CardView.swift
//  Test Task
//
//  Created by Анна Шапагатян on 29.08.22.
//

import UIKit

class CardView: UIView {
    // MARK: - Views
//       private lazy var stackView: UIStackView = {
//        let stack = UIStackView()
//        stack.spacing = 20
//        stack.backgroundColor = .red
//        stack.axis = .vertical
//        stack.alignment = .center
//        stack.distribution = .fill
//        return stack
//    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 20
        imageView.setShadow()
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Setup UI
private extension CardView {
    func setupUI() {
        addStackView()
        backgroundColor = UIColor(white: 1, alpha: 0.2)
    }

    // MARK: Stack view
    func addStackView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        imageView.pinEdgesToSuperView(top: 8, left: 25, bottom: 8, right: 25)
    }

    // MARK: Empty view
    func addEmptyView() {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(view)
        view.backgroundColor = .clear
    }
}

// extension CardView {
//    public func setData(_ item: Product) {
//        imageView.setImage(imageURL: item.images[1])
//    }
// }
