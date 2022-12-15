//
//  ViewController.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import Combine
import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var cancellable: Set<AnyCancellable> = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startup()
        setupBindings()
    }
}

// MARK: - Setup UI
extension ViewController {
    @objc func setupUI() {
        view.backgroundColor = UIColor(hex: "#F8F8F8")
    }

    @objc func setupBindings() {}

    @objc func startup() {}
}
