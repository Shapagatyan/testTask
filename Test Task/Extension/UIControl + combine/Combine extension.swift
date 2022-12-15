//
//  Combine extension.swift
//  Test Task Effective Mobile
//
//  Created by Анна Шапагатян on 07.12.22.
//

import UIKit
import Combine

protocol CombineCompatible { }
extension UIControl: CombineCompatible { }
extension CombineCompatible where Self: UIControl {
    func subscribe(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}
