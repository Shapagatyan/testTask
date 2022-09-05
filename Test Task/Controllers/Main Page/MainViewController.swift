//
//  MainViewController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import Alamofire
import PanModal
import UIKit

class MainViewController: ViewController {
    // MARK: - Views
    @IBOutlet var mainCollectionView: UICollectionView!

    // MARK: - Properties
    var bestSallers: [BestSeller] = []
    var headers: [MainPage] = MainPage.allCases

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
}

// MARK: - SetupUI
extension MainViewController {
    func setupUI() {
        setupCollectioView()
        setupNavigationBur()
    }

    func setupCollectioView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.registerCell(cellType: HotSalesCell.self)
        mainCollectionView.registerCell(cellType: BestSellersCell.self)
        mainCollectionView.registerCell(cellType: MainPageFirstCell.self)
        mainCollectionView.registerCell(cellType: MainPageSecondCell.self)
        mainCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.name)
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

// MARK: - Request
extension MainViewController {
    func getData() {
        let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
        AF.request(url!, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let salers = try JSONDecoder().decode(HotSales.self, from: data)
                    self.bestSallers = salers.bestSeller
                    self.mainCollectionView.reloadData()
                    self.mainCollectionView.layoutSubviews()
                } catch {
                    print("Ошибка")
                    self.alert(title: "Ошибка", message: "")
                }
            case .failure:
                print("Ошибка")
            }
        }
    }
}

// MARK: - CollectionView methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headers.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = headers[section]
        switch section {
        case .bestSellers:
            return bestSallers.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = headers[indexPath.section]

        switch section {
        case .selectCategories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageFirstCell.name, for: indexPath) as! MainPageFirstCell
            return cell
        case .hotSales:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageSecondCell.name, for: indexPath) as! MainPageSecondCell
            return cell
        case .bestSellers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellersCell.name, for: indexPath) as! BestSellersCell
            let sallers = bestSallers[indexPath.row]
            cell.setData(section: sallers)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let section = headers[indexPath.section]

        switch section {
        case .selectCategories:
            return CGSize(width: width, height: 95)
        case .hotSales:
            return CGSize(width: width, height: 189)
        case .bestSellers:
            return CGSize(width: collectionView.frame.width * 0.42, height: 227)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
            header.title.text = headers[indexPath.section].title
            let section = headers[indexPath.section]

            switch section {
            case .selectCategories:
                header.seeMoreButton.setTitle("view all", for: .normal)
            default:
                header.seeMoreButton.isHidden = false
            }
            return header
        default:
            break
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        return CGSize(width: collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right - 24, height: 27)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = headers[indexPath.section]

        switch section {
        case .bestSellers:
            let vc = ProductDetailsController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

// MARK: - Helpers
enum MainPage: CaseIterable {
    case selectCategories
    case hotSales
    case bestSellers

    var title: String {
        switch self {
        case .selectCategories:
            return "Select Category"
        case .hotSales:
            return "Hot Sales"
        case .bestSellers:
            return "Best Seller"
        }
    }
}
