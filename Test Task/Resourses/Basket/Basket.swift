//
//  Basket.swift
//  Test Task Effective Mobile
//
//  Created by Анна Шапагатян on 09.12.22.
//

import Alamofire
import Foundation
import UIKit

class Basket: NSObject {
    static let shared = Basket()
    @Published private(set) var products: [BasketProduct] = []
//    @Published private(set) var count: Int = 1

    override private init() {
        super.init()
        getBasketProducts()
    }
}

extension Basket {
    func getBasketProducts() {
        let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")
        AF.request(url!, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(BascetItems.self, from: data)
                    self.products = items.basket.map { BasketProduct(product: $0) }
                } catch {
                    print("Ошибка")
                }
            case .failure:
                print("Ошибка")
            }
        }
    }
}

extension Basket {
    func decrementProduct(item: BasketProduct) {
        guard let index = products.firstIndex(where: { $0.product.id == item.product.id }) else { return }
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            var products = self.products
            products[index].count -= 1
            if products[index].count == 0 {
                products.remove(at: index)
            }
            self.products = products
        })
    }

    func incrementProduct(item: BasketProduct) {
        guard let index = products.firstIndex(where: { $0.product.id == item.product.id }) else { return }
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            let products = self.products
            products[index].count += 1
            self.products = products
        })
    }

    func deleteProduct(item: BasketProduct) {
        guard let index = products.firstIndex(where: { $0.product.id == item.product.id }) else { return }
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            var products = self.products
            products.remove(at: index)
            self.products = products
        })
    }
}
