//
//  FilterOptionsController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import PanModal
import UIKit

class FilterOptionsController: UIViewController {
    // MARK: - Views
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var tableView: UITableView!

    // MARK: - Properties
    var options: [Options] = Options.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - SetupUI
extension FilterOptionsController {
    func setupUI() {
        setupViews()
        setupTableView()
    }

    func setupViews() {
        doneButton.layer.cornerRadius = 8
        backButton.layer.cornerRadius = 8
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName: FilterPositionCell.name, bundle: nil), forCellReuseIdentifier: FilterPositionCell.name)
    }
}

// MARK: - Actions
extension FilterOptionsController {
    @IBAction func closedAction(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func doneAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Delegates
extension FilterOptionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterPositionCell.name, for: indexPath) as! FilterPositionCell
        cell.optionTextField.placeholder = options[indexPath.row].placeHolder
        cell.optionLabel.text = options[indexPath.row].label
        return cell
    }

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
