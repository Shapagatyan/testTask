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
    @IBOutlet var backView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var coastLabel: UILabel!
    @IBOutlet var checkoutButton: UIButton!

    // MARK: - Properties
    var products: [BasketProduct] = [] {
        didSet {
            updateSummary()
        }
    }

    let count = 0

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
}

// MARK: - SetupUI
extension MyCardController {
    func setupUI() {
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SelectItemCell.name, bundle: nil), forCellReuseIdentifier: SelectItemCell.name)
    }
}

// MARK: - Request
extension MyCardController {
    func getData() {
        let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")
        AF.request(url!, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(BascetItems.self, from: data)
                    self.products = items.basket.map { BasketProduct(product: $0) }
                    self.tableView.reloadData()
                    self.tableView.layoutSubviews()
                } catch {
                    print("Ошибка")
                }
            case .failure:
                print("Ошибка")
            }
        }
    }
}

// MARK: - Actions
extension MyCardController {
    @objc func changeLocation() {}

    @objc func goToBack() {
        navigationController?.popViewController(animated: true)
    }

    private func updateSummary() {
        let amount = products.map { $0.product.price * $0.count }.reduce(0, +)
        coastLabel.text = "$ " + String(amount)
    }
}

// MARK: - Table delegate & datasource
extension MyCardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectItemCell.name, for: indexPath) as! SelectItemCell
        cell.delegate = self
        cell.setData(item: products[indexPath.row])
        return cell
    }
}

// MARK: - Cell delegate
extension MyCardController: SelectItemCellDelegate {
    func productCellPlusAction(_ product: BasketProduct) {
        guard let index = products.firstIndex(where: { $0.product.id == product.product.id }) else { return }
        products[index].count += 1
        tableView.reloadData()
        updateSummary()
    }

    func productCellMinusAction(_ product: BasketProduct) {
        guard let index = products.firstIndex(where: { $0.product.id == product.product.id }) else { return }
        products[index].count -= 1
        if products[index].count == 0 {
            products.remove(at: index)
        }
        tableView.reloadData()
        updateSummary()
    }
}

class BasketProduct {
    let product: Product
    var count: Int

    internal init(product: Product, count: Int = 1) {
        self.product = product
        self.count = count
    }
}
