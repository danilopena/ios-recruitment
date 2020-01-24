//
//  String+Extension.swift
//  SampleApp
//
//  Created by Danilo Pena on 24/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
