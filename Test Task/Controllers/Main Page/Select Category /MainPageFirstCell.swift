//
//  MainPageFirstCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import UIKit

class MainPageFirstCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Properties
    var categories: [Categories] = Categories.allCases

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
}

// MARK: - SetupUI
extension MainPageFirstCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cellType: CategoriesCell.self)
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - Delegates
extension MainPageFirstCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.name, for: indexPath) as! CategoriesCell
        cell.cellConfiguration(categories[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 71, height: 95)
    }
}

// MARK: - Helpers
enum Categories: CaseIterable {
    case phones
    case computers
    case health
    case books
    case tools

    var image: UIImage? {
        switch self {
        case .phones:
            return UIImage(named: "Phones")
        case .computers:
            return UIImage(named: "Computers")
        case .health:
            return UIImage(named: "Health1")
        case .books:
            return UIImage(named: "Books")
        case .tools:
            return UIImage(named: "Phones")
        }
    }

    var name: String {
        switch self {
        case .phones:
            return "Phones"
        case .computers:
            return "Computers"
        case .health:
            return "Health"
        case .books:
            return "Books"
        case .tools:
            return "Tools"
        }
    }
}
