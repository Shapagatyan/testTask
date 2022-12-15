//
//  MainViewModel.swift
//  Test Task
//
//  Created by Анна Шапагатян on 04.12.22.
//

import Alamofire
import Foundation

class MainViewModel: ViewModel {
    @Published private(set) var models: [MainPageSection] = []
}

extension MainViewModel {
    override func setupBindings() {
        let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
        AF.request(url!, method: .get).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let salers = try JSONDecoder().decode(HotSales.self, from: data)
                    self?.configureData(model: salers)
                } catch {
                    print("Ошибка")
                }
            case .failure:
                print("Ошибка")
            }
        }
    }

    private func configureData(model: HotSales) {
        let categories = MainPageModel.categories(items: Category.allCases)
        let hotSallers = MainPageModel.hotSale(items: model.homeStore)
        let bestSellers = model.bestSeller.map { MainPageModel.bestSeller(item: $0) }

        self.models = [
            .selectCategories(items: [categories]),
            .hotSalles(items: [hotSallers]),
            .bestSellers(items: bestSellers)
        ]
    }
}

// MARK: - Helpers
enum MainPageSection: Equatable, Hashable {
    case selectCategories(items: [MainPageModel])
    case hotSalles(items: [MainPageModel])
    case bestSellers(items: [MainPageModel])

    var title: String {
        switch self {
        case .selectCategories:
            return "Select Category"
        case .hotSalles:
            return "Hot Sales"
        case .bestSellers:
            return "Best Seller"
        }
    }

    var items: [MainPageModel] {
        switch self {
        case .selectCategories(let items):
            return items
        case .hotSalles(let items):
            return items
        case .bestSellers(let items):
            return items
        }
    }
}

enum MainPageModel: Equatable, Hashable {
    case categories(items: [Category])
    case hotSale(items: [HomeStore])
    case bestSeller(item: BestSeller)
}
