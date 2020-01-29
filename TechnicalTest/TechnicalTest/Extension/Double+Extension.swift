//
//  Double+Extension.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 28/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension Double {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
