//
//  Product Model .swift
//  Test Task Effective Mobile
//
//  Created by Анна Шапагатян on 15.12.22.
//


import RealmSwift

class ProductDetails: Codable {
    let cpu, camera: String
    let capacity, color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd, ssd, title: String

    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case camera, capacity, color, id, images, isFavorites, price, rating, sd, ssd, title
    }
}
