//
//  FilterPositionCell.swift
//  Test Task
//
//  Created by Анна Шапагатян on 24.08.22.
//

import UIKit

class FilterPositionCell: UITableViewCell {
    // MARK: - Views
    @IBOutlet var optionLabel: UILabel!
    @IBOutlet var optionTextField: UITextField!
    
    func setData(option: Options) {
        optionTextField.placeholder = option.placeHolder
        optionLabel.text = option.label
    }
}
