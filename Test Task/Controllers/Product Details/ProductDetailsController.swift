//
//  ProductDetailsController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Alamofire
import CollectionViewPagingLayout
import Cosmos
import UIKit

class ProductDetailsController: ViewController {
    // MARK: - Views
    @IBOutlet var backView: UIView!
    @IBOutlet var sdLabel: UILabel!
    @IBOutlet var ssdLabel: UILabel!
    @IBOutlet var cpuLabel: UILabel!
    @IBOutlet var orangeView: UIView!
    @IBOutlet var sliderView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var coastLabel: UILabel!
    @IBOutlet var shopButton: UIButton!
    @IBOutlet var cameraLabel: UILabel!
    @IBOutlet var cosmosView: CosmosView!
    @IBOutlet var detailsButton: UIButton!
    @IBOutlet var featuresButton: UIButton!
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var isFavoriteButton: UIButton!
    @IBOutlet var viewForAddToCartButton: UIView!
    @IBOutlet var colorCollectionView: UICollectionView!
    @IBOutlet var capacityCollectionView: UICollectionView!
    @IBOutlet var progressLeftConstraint: NSLayoutConstraint!
    @IBOutlet var itemPictureCollectionView: UICollectionView!

    // MARK: - Properties
    var product: ProductDetails?

    private lazy var collectionLayout: CollectionViewPagingLayout = {
        let layout = CollectionViewPagingLayout()
        return layout
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        itemPictureCollectionView.performBatchUpdates({ [weak self] in
            self?.itemPictureCollectionView.collectionViewLayout.invalidateLayout()
        })
    }

    @objc func changeSliderConstraint() {
        if shopButton.isSelected {
            progressLeftConstraint.constant = 300
        }
    }
}

// MARK: - SetupUI
extension ProductDetailsController {
    func setupUI() {
        setupViews()
        setupNavigationBar()
        setupColorCollectionView()
        setupCapacityCollectionView()
        setupItemPictureCollectionView()
    }

    func setupViews() {
        backView.setShadow()
        backView.layer.cornerRadius = 25
        isFavoriteButton.layer.cornerRadius = 6
        viewForAddToCartButton.layer.cornerRadius = 10
    }

    func setupNavigationBar() {
        navigationItem.title = "Product Details"
        colorCollectionView.delegate = self
        navigationItem.setLeftBarButtonItem(caller: self, color: UIColor(hex: "#010035"), icon: "ArrowBack", action: #selector(goToBack))
    }

    func setupItemPictureCollectionView() {
        itemPictureCollectionView.delegate = self
        itemPictureCollectionView.dataSource = self
        itemPictureCollectionView.isPagingEnabled = true
        itemPictureCollectionView.showsVerticalScrollIndicator = false
        itemPictureCollectionView.showsHorizontalScrollIndicator = false
        itemPictureCollectionView.registerCell(cellType: ImageCell.self)
        itemPictureCollectionView.setCollectionViewLayout(collectionLayout, animated: true)
    }

    func setupColorCollectionView() {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.registerCell(cellType: ColorCell.self)
    }

    func setupCapacityCollectionView() {
        capacityCollectionView.delegate = self
        capacityCollectionView.dataSource = self
        capacityCollectionView.registerCell(cellType: CapacityCell.self)
    }
}

// MARK: - IBActions
extension ProductDetailsController {
    @IBAction func ShowShopAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
            self.orangeView.transform = CGAffineTransform(translationX: sender.frame.origin.x, y: 0)
        })
    }

    @IBAction func showDetailsAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
            self.orangeView.transform = CGAffineTransform(translationX: sender.frame.origin.x, y: 0)
        })
    }

    @IBAction func showFeaturesAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
            self.orangeView.transform = CGAffineTransform(translationX: sender.frame.origin.x, y: 0)
        })
    }

    @IBAction func addToCartAction(_ sender: UIButton) {}
}

// MARK: - Actions
extension ProductDetailsController {
    @objc func goToMyCard() {}

    @objc func goToBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Request
extension ProductDetailsController {
    func getData() {
        let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")
        AF.request(url!, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let item = try JSONDecoder().decode(ProductDetails.self, from: data)
                    self.product = item
                    self.setData()
                } catch {
                    print("Ошибка")
                }
            case .failure:
                print("Ошибка")
            }
        }
    }
}

// MARK: - SetData Action
extension ProductDetailsController {
    func setData() {
        guard let product = self.product else { return }
        sdLabel.text = product.sd
        ssdLabel.text = product.ssd
        cpuLabel.text = product.cpu
        titleLabel.text = product.title
        cameraLabel.text = product.camera
        cosmosView.rating = product.rating
        cosmosView.rating = product.rating
        coastLabel.text = "$ " + String(product.price) + ".00"
        if product.isFavorites == false {
            isFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        itemPictureCollectionView.reloadData()
        capacityCollectionView.reloadData()
        capacityCollectionView.layoutSubviews()
        capacityCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        colorCollectionView.reloadData()
        colorCollectionView.layoutSubviews()
        colorCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - Delegates
extension ProductDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let product = self.product else { return 0 }
        switch collectionView {
        case itemPictureCollectionView:
            return product.images.count
        case colorCollectionView:
            return product.color.count
        case capacityCollectionView:
            return product.capacity.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let product = self.product else {
            let cell = UICollectionViewCell()
            cell.backgroundColor = .green
            return cell
        }

        switch collectionView {
        case itemPictureCollectionView:
            let cell = itemPictureCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.name, for: indexPath) as! ImageCell
            cell.cardView.imageView.setImage(imageURL: product.images[indexPath.row])
            return cell
        case colorCollectionView:
            let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.name, for: indexPath) as! ColorCell
            cell.backView.backgroundColor = UIColor(hex: product.color[indexPath.row])
            return cell
        case capacityCollectionView:
            let cell = capacityCollectionView.dequeueReusableCell(withReuseIdentifier: CapacityCell.name, for: indexPath) as! CapacityCell
            cell.capacityLabel.text = product.capacity[indexPath.row] + " GB"
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case itemPictureCollectionView:
            let height = itemPictureCollectionView.frame.height
            return CGSize(width: height * 0.7, height: height)
        case colorCollectionView:
            let height = colorCollectionView.frame.height
            return CGSize(width: 40, height: height)
        case capacityCollectionView:
            let height = capacityCollectionView.frame.height
            return CGSize(width: 72, height: height)
        default:
            return CGSize(width: 20, height: 20)
        }
    }
}
