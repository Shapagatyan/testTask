//
//  Basket Model.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Foundation

class BasketProduct: NSObject {
    let product: Product
    var count: Int

    internal init(product: Product, count: Int = 1) {
        self.product = product
        self.count = count
    }
}

// MARK: - BascetItems
class BascetItems: Codable {
    let basket: [Product]
    let delivery, id: String
    let total: Int
}

// MARK: - Basket
class Product: Codable {
    var id = UUID().uuidString
    let price: Int
    let title: String
    let images: String
    var count: Int = 1

    enum CodingKeys: String, CodingKey {
        case images, price, title
    }
}
