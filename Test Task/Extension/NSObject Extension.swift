//
//  NSObject extension.swift
//  Test Task
//
//  Created by Анна Шапагатян on 22.08.22.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
