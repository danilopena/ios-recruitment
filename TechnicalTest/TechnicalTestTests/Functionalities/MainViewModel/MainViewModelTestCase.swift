//
//  MainViewModelTesteCase.swift
//  TechnicalTestTests
//
//  Created by Danilo Pena on 28/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest
@testable import TechnicalTest

class MainViewModelTestCase: XCTestCase {

    private var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel(delegate: self)
        viewModel.latestExchange = LatestListOfCurrencies(rates: ["BRL": 4.60], base: "USD", date: "")
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testMultiplyConversion() {
        let result = viewModel.multiplyConversion(value1: 10, value2: 2)
        XCTAssertEqual(result, 20)
    }
    
    func testDivisionConversion() {
        let result = viewModel.divisionConversion(value1: 10, value2: 2)
        XCTAssertEqual(result, 5)
    }
    
    func testBaseCurrency() {
        let baseCurrencyString = viewModel.baseCurrency
        XCTAssertNotNil(baseCurrencyString)
        XCTAssertNotEqual(viewModel.baseCurrency, MainViewModel.Constants.defaultText)
    }
    
    func testRatesKeys() {
        XCTAssertNotNil(viewModel.ratesKeys)
    }
}

extension MainViewModelTestCase: MainViewModelDelegate {
    func loaded(state: State) {}
}
