//
//  MainPageSecondCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import Alamofire
import Combine
import Kingfisher
import UIKit

class HotSalesCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Properties
    @Published var homeStore: [HomeStore] = []
    var cancellable: Set<AnyCancellable> = []
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, HomeStore>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, HomeStore>

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSaleCell.name, for: indexPath) as! HotSaleCell
            cell.setData(item: model)
            return cell
        }
        return dataSource
    }()

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBindings()
        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.registerCell(cellType: HotSaleCell.self)
    }
}

// MARK: - Request
extension HotSalesCell {
    func setupBindings() {
        $homeStore.delay(for: 0.1, scheduler: RunLoop.main).sink { [weak self] models in
            guard let `self` = self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(models)
            self.dataSource.applySnapshotUsingReloadData(snapshot)
        }.store(in: &cancellable)
    }
}

// MARK: - Delegates
extension HotSalesCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width - 34, height: 190)
    }
}

// MARK: - Public methods
extension HotSalesCell {
    func setHotSales(_ items: [HomeStore]) {
        homeStore = items
    }
}
