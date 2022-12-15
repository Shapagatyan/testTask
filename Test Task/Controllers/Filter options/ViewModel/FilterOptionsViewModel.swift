//
//  FilterOptionsViewModel.swift
//  Test Task Effective Mobile
//
//  Created by Анна Шапагатян on 07.12.22.
//

import UIKit
import Combine

class FilterOptionsViewModel: ViewModel {
    @Published private(set) var options: [Options] = Options.allCases
}

