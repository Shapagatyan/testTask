//
//  MainPageSecondCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 23.08.22.
//

import Alamofire
import Kingfisher
import UIKit

class MainPageSecondCell: UICollectionViewCell {
    // MARK: - Views
    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Properties
    var homeStore: [HomeStore] = []

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cellType: HotSalesCell.self)
    }
}

// MARK: - Request
extension MainPageSecondCell {
    func getData() {
        let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")

        AF.request(url!, method: .get).responseData { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(let data):
                do {
                    let salers = try JSONDecoder().decode(HotSales.self, from: data)
                    self.homeStore = salers.homeStore
                    self.collectionView.reloadData()
                    self.collectionView.layoutSubviews()
                } catch {
                    print("Ошибка")
                }
            case .failure(let error):
                print("Ошибка:", error.localizedDescription)
            }
        }
    }
}

// MARK: - Delegates
extension MainPageSecondCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeStore.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.name, for: indexPath) as! HotSalesCell
        let seller = homeStore[indexPath.item]
        cell.setData(section: seller)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width - 34, height: 189)
    }
}
