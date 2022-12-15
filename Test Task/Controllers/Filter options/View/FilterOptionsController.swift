//
//  FilterOptionsController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Combine
import PanModal
import UIKit

class FilterOptionsController: ViewController {
    
    // MARK: - Views
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var doneButton: UIButton!
    @IBOutlet private var tableView: UITableView!

    // MARK: - Properties
    var viewModel =  FilterOptionsViewModel()

//        var cancellable: Set<AnyCancellable> = []
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Options>
    typealias DataSource = UITableViewDiffableDataSource<Section, Options>

    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { [weak self] tableView, indexPath, model in

            let cell = tableView.dequeueReusableCell(withIdentifier: FilterPositionCell.name, for: indexPath) as! FilterPositionCell
//            guard let self = self else { return }
            cell.setData(option: model)
//            cell.optionTextField.placeholder =  self?.viewModel.options[indexPath.row].placeHolder
//            cell.optionLabel.text = self?.viewModel.options[indexPath.row].label
            return cell
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
extension FilterOptionsController {
    override func setupUI() {
        setupViews()
        setupTableView()
    }

    func setupViews() {
        doneButton.layer.cornerRadius = 8
        backButton.layer.cornerRadius = 8
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName: FilterPositionCell.name, bundle: nil), forCellReuseIdentifier: FilterPositionCell.name)
    }

     override func setupBindings() {
         super.setupBindings()
        viewModel.$options.receive(on: RunLoop.main).sink { [weak self] model in
            guard let self = self else { return }
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(model)
            self.dataSource.applySnapshotUsingReloadData(snapshot, completion: nil)
        }.store(in: &cancellable)
         
         doneButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
             self?.dismiss(animated: true)
         }.store(in: &cancellable)
         
         backButton.subscribe(for: .touchUpInside).sink { [weak self] _ in
             self?.dismiss(animated: true)
         }.store(in: &cancellable)
    }
    
}

// MARK: - Delegates
 extension FilterOptionsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 }

// MARK: - PanModal
extension FilterOptionsController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(320)
    }

    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.2)
    }
}

// MARK: - Helpers
enum Options: CaseIterable {
    case brand
    case size
    case price

    var placeHolder: String {
        switch self {
        case .brand:
            return "Samsung"
        case .size:
            return "$100 - $1000"
        case .price:
            return "4.5 to 5.5 inches"
        }
    }

    var label: String {
        switch self {
        case .brand:
            return "Brand"
        case .size:
            return "Size"
        case .price:
            return "Price"
        }
    }
}
