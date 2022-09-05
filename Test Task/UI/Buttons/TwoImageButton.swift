//
//  TwoImageButton.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import UIKit

class TwoImageButton: UIControl {
    // MARK: - Views
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = false
        return stackView
    }()

    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let centerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(hex: "#010035")
        return label
    }()

    private let rightImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()

    // MARK: - Properties
    public var leftImage: UIImage? {
        set {
            leftImageView.image = newValue
        }
        get {
            return leftImageView.image
        }
    }

    public var rightImage: UIImage? {
        set {
            rightImageView.image = newValue
        }
        get {
            return rightImageView.image
        }
    }

    public var text: String? {
        set {
            centerLabel.text = newValue
        }
        get {
            return centerLabel.text
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Setup UI
private extension TwoImageButton {
    func setupUI() {
        addStackView()
        addLeftImageView()
        addCenterLabel()
        addRightImageView()
        backgroundColor = .clear
    }

    func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }

    func addLeftImageView() {
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(leftImageView)

        leftImageView.addRatioConstraint()
    }

    func addCenterLabel() {
        stackView.addArrangedSubview(centerLabel)
    }

    func addRightImageView() {
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(rightImageView)
        rightImageView.addRatioConstraint()
    }
}
