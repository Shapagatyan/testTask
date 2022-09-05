//
//  HeaderMainPage.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
    // MARK: - Views
    lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("see more", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 15)
        button.setTitleColor(UIColor(hex: "#FF6E4E"), for: .normal)
        return button
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.textColor = UIColor(hex: "#010035")
        title.font = UIFont(name: "Avenir Book", size: 25)
//        MarkPro-Bold
        return title
    }()
    
    // MARK: - Properties
    static let buttonID = "ButtonID"
    static let reuseID = "SectionHeader"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI
extension SectionHeader {
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(seeMoreButton)
        NSLayoutConstraint.activate([
            seeMoreButton.topAnchor.constraint(equalTo: topAnchor),
            seeMoreButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            seeMoreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
//            seeMoreButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            title.rightAnchor.constraint(lessThanOrEqualTo: seeMoreButton.leftAnchor, constant: -16),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
        ])
    }
}
