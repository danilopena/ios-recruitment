//
//  Endpoint.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 26/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

enum Endpoint: String {
    case baseUrl = "https://api.exchangeratesapi.io"
    case latestExchange = "/latest"
    
    // Where "symbols" are the currencies which you wanna and "base"
    // The destination currency
    case exchangeWithBase = "/latest/symbols=%@&base=%@"
}
