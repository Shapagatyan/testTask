//
//  MainPageFirstCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import Combine
import UIKit

class CategoriesCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Properties
    @Published var categories: [Category] = []
    var cancellable: Set<AnyCancellable> = []
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Category>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Category>

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.name, for: indexPath) as! CategoryCell
            cell.cellConfiguration(model)
            return cell
        }
        return dataSource
    }()

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setupBinding()
    }
}

// MARK: - SetupUI
extension CategoriesCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.registerCell(cellType: CategoryCell.self)
    }

    func setupBinding() {
        $categories.receive(on: RunLoop.main).sink { [weak self] models in
            guard let self = self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(models)
            self.dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)
            self.collectionView.layoutIfNeeded()
            guard !models.isEmpty else { return }
            self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }.store(in: &cancellable)
    }
}

// MARK: - Delegates
extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 71, height: 95)
    }
}

// MARK: - Public methods
extension CategoriesCell {
    func setCategories(_ items: [Category]) {
        categories = items
    }
}

enum Section {
    case main
}
