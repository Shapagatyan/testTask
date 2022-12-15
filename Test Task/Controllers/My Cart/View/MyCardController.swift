//
//  MyCardController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Alamofire
import Realm
import UIKit

class MyCardController: ViewController {
    // MARK: - Views
    @IBOutlet private var backView: UIView!
    @IBOutlet private var coastLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var checkoutButton: UIButton!

    // MARK: - Properties
    var viewModel = MyCardViewModel()
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BasketProduct>
    typealias DataSource = UITableViewDiffableDataSource<Section, BasketProduct>

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in

            let cell = tableView.dequeueReusableCell(withIdentifier: SelectItemCell.name, for: indexPath) as! SelectItemCell
            cell.delegate = self
            cell.setData(item: item)
            return cell
        }
        return dataSource
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
extension MyCardController {
    override func setupUI() {
        setupViews()
        setupTableView()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationItem.title = "Add address"
        navigationItem.setRightBarButtonItem(caller: self, color: UIColor(hex: "#FF6E4E"), icon: "LocationWhite", action: #selector(changeLocation))
    }

    func setupViews() {
        backView.layer.cornerRadius = 25
        checkoutButton.layer.cornerRadius = 10
    }

    func setupTableView() {
        tableView.register(UINib(nibName: SelectItemCell.name, bundle: nil), forCellReuseIdentifier: SelectItemCell.name)
    }
}

// MARK: - Binding
extension MyCardController {
    override func setupBindings() {
        super.setupBindings()
        viewModel.$products.receive(on: RunLoop.main).sink { [weak self] model in
            guard let self = self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(model)
            self.dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)
        }.store(in: &cancellable)

        viewModel.$summary.sink { [weak self] amount in
            guard let `self` = self else { return }
            self.coastLabel.text = "$ " + String(amount).currencyInputFormatting()
        }.store(in: &cancellable)
    }
}

// MARK: - Actions
extension MyCardController {
    @objc func changeLocation() {}

    @objc func goToBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Cell delegate
extension MyCardController: SelectItemCellDelegate {
    func productCellDeleteAction(_ product: BasketProduct) {
        viewModel.deletProduct(item: product)
    }

    func productCellPlusAction(_ product: BasketProduct) {
        viewModel.incrementProduct(item: product)
    }

    func productCellMinusAction(_ product: BasketProduct) {
        viewModel.decrementProduct(item: product)
    }
}
