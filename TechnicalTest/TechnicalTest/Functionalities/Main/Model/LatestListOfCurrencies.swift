//
//  LatestListOfCurrencies.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 26/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class LatestListOfCurrencies: Codable {
    var rates: [String: Double]?
    var base: String?
    var date: String?
}
