//
//  UIView+Extension.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 29/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension UIView {
    /// Finds the selected TextField in View.
    var textFieldsInView: [UITextField] {
        return subviews
            .filter ({ !($0 is UITextField) })
            .reduce (( subviews.compactMap { $0 as? UITextField }), { summ, current in
                return summ + current.textFieldsInView
        })
    }
    var selectedTextField: UITextField? {
        return textFieldsInView.filter { $0.isFirstResponder }.first
    }
}
