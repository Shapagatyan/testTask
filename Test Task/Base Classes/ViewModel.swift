//
//  ViewModel.swift
//  Test Task
//
//  Created by Анна Шапагатян on 04.12.22.
//

import Combine
import UIKit

class ViewModel: NSObject {
    var cancellable: Set<AnyCancellable> = []

    override init() {
        super.init()
        setupBindings()
    }
}

extension ViewModel {
    @objc func setupBindings() {}
}
