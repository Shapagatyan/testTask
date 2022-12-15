//
//  MainViewController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import Alamofire
import Combine
import PanModal
import UIKit

class MainViewController: ViewController {
    // MARK: - Views
    @IBOutlet private var mainCollectionView: UICollectionView!

    // MARK: - Properties
    var viewModel = MainViewModel()
    typealias Snapshot = NSDiffableDataSourceSnapshot<MainPageSection, MainPageModel>
    typealias DataSource = UICollectionViewDiffableDataSource<MainPageSection, MainPageModel>

    // MARK: - DataSource
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: mainCollectionView) { [weak self] collectionView, indexPath, model in

            switch model {
            case .categories(let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.name, for: indexPath) as! CategoriesCell
                cell.setCategories(items)
                return cell
            case .hotSale(let items):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.name, for: indexPath) as! HotSalesCell
                cell.setHotSales(items)
                return cell
            case .bestSeller(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellersCell.name, for: indexPath) as! BestSellersCell
                cell.setData(section: item)
                return cell
            }
        }
        return dataSource
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - SetupUI
extension MainViewController {
    override func setupUI() {
        super.setupUI()
        setupCollectioView()
        setupNavigationBur()
    }

    func setupCollectioView() {
        mainCollectionView.delegate = self
        mainCollectionView.registerCell(cellType: HotSalesCell.self)
        mainCollectionView.registerCell(cellType: CategoriesCell.self)
        mainCollectionView.registerCell(cellType: BestSellersCell.self)
        mainCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.name)
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
    }

    func setupNavigationBur() {
        let button = TwoImageButton()
        button.text = "Zihuatanejo, Gro"
        button.leftImage = UIImage(named: "Location")
        button.rightImage = UIImage(named: "DropDown")

        navigationItem.titleView = button
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#010035")
        navigationItem.setRightBarButtonItem(caller: self, color: UIColor(.clear), icon: "Vector", action: #selector(filterOptionsPanModal))
    }
}

// MARK: - Actions
extension MainViewController {
    @objc func filterOptionsPanModal() {
        let vc = FilterOptionsController()
        presentPanModal(vc)
    }
}

// MARK: - Binding
extension MainViewController {
    override func setupBindings() {
        super.setupBindings()
        viewModel.$models.dropFirst().delay(for: 0.1, scheduler: RunLoop.main).sink { [weak self] models in
            guard let `self` = self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections(models)
            models.forEach { snapshot.appendItems($0.items, toSection: $0) }
            self.dataSource.apply(snapshot)
        }.store(in: &cancellable)
    }
}

// MARK: - CollectionView methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard viewModel.models.indices.contains(indexPath.section) else { return .zero }
        let width = collectionView.frame.width
        let section = viewModel.models[indexPath.section]
        switch section {
        case .selectCategories:
            return CGSize(width: width, height: 95)
        case .hotSalles:
            return CGSize(width: width, height: 190)
        case .bestSellers:
            return CGSize(width: width * 0.42, height: 228)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        return CGSize(width: collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right - 24, height: 32)
    }

    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
        header.title.text = viewModel.models[indexPath.section].title
        let section = viewModel.models[indexPath.section]

        switch section {
        case .selectCategories:
            header.seeMoreButton.setTitle("view all", for: .normal)
        default:
            header.seeMoreButton.isHidden = false
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.models[indexPath.section].items[indexPath.row]

        switch model {
        case .bestSeller:
            let vc = ProductDetailsController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
