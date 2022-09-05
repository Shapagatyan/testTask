//
//  Basket Model.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Foundation

// MARK: - BascetItems
class BascetItems: Codable {
    let basket: [Product]
    let delivery, id: String
    let total: Int
}

// MARK: - Basket
class Product: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
