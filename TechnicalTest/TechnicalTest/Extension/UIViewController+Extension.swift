//
//  UIViewController+Extension.swift
//  SampleApp
//
//  Created by Danilo Pena on 24/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Prompt a simple alert.
    func alert(title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true) {}
    }
}
