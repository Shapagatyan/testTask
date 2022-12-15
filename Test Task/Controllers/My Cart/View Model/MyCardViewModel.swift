//
//  MyCardViewModel.swift
//  Test Task Effective Mobile
//
//  Created by Анна Шапагатян on 05.12.22.
//

import Alamofire
import Combine
import UIKit

class MyCardViewModel: ViewModel {
    @Published private(set) var products: [BasketProduct] = []
    @Published private(set) var summary: Int = 0
}

extension MyCardViewModel {
    override func setupBindings() {
        Basket.shared.$products.sink { [weak self] items in
            self?.products = items
        }.store(in: &cancellable)
        
        $products.receive(on: RunLoop.main).sink { [weak self] _ in
            guard let `self` = self else { return }
            self.summary = self.products.map { $0.product.price * $0.count }.reduce(0, +)
        }.store(in: &cancellable)
    }
    
    func decrementProduct(item: BasketProduct) {
        Basket.shared.decrementProduct(item: item)
    }

    func incrementProduct(item: BasketProduct) {
        Basket.shared.incrementProduct(item: item)
    }
    
    func deletProduct(item: BasketProduct) {
        Basket.shared.deleteProduct(item: item)
    }
}
