//
//  Category.swift
//  Test Task Effective Mobile
//
//  Created by Анна Шапагатян on 05.12.22.
//

import UIKit

// MARK: - Helpers
enum Category: CaseIterable {
    case phones
    case computers
    case health
    case books
    case tools

    var image: UIImage? {
        switch self {
        case .phones:
            return UIImage(named: "Phones")
        case .computers:
            return UIImage(named: "Computers")
        case .health:
            return UIImage(named: "Health1")
        case .books:
            return UIImage(named: "Books")
        case .tools:
            return UIImage(named: "Phones")
        }
    }

    var name: String {
        switch self {
        case .phones:
            return "Phones"
        case .computers:
            return "Computers"
        case .health:
            return "Health"
        case .books:
            return "Books"
        case .tools:
            return "Tools"
        }
    }
}
