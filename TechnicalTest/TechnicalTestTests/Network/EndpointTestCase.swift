//
//  EndpointTestCase.swift
//  TechnicalTestTests
//
//  Created by Danilo Pena on 28/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest
@testable import TechnicalTest

class EndpointTestCase: XCTestCase {
    
    func testEndpoints() {
        let baseUrl = Endpoint.baseUrl.rawValue
        XCTAssertEqual(baseUrl, "https://api.exchangeratesapi.io")
        
        let latest = Endpoint.latestExchange.rawValue
        XCTAssertEqual(latest, "/latest")
        
        let exchangeWithBase = Endpoint.exchangeWithBase.rawValue
        XCTAssertEqual(exchangeWithBase, "/latest/symbols=%@&base=%@")
    }
}

