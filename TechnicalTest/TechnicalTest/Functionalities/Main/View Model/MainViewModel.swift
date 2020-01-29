//
//  MainViewModel.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 26/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func loaded(state: State)
}

final class MainViewModel {
    private weak var delegate: MainViewModelDelegate?
    var latestExchange: LatestListOfCurrencies?
    var destination: String?
    
    init(delegate: MainViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchLatestExchange(_ base: String? = nil) {
        Loader.showDefaultLoader()
        ExchangeService<LatestListOfCurrencies>().fetchLatest(base: base, completion: {
            [weak self] response in
            guard let self = self else { return }
            Loader.hideDefaultLoading()
            self.latestExchange = response
            self.delegate?.loaded(state: .success)
        }, error: {message in
            Loader.hideDefaultLoading()
            self.delegate?.loaded(state: .failed(error: message))
        })
    }
    
    func makeCalcOfConversion(valueForBase: Double) -> Double {
        if destination == nil {
            destination = Currencies.BRL.rawValue
        }
        
        let destinationFinded = latestExchange?.rates?.filter({$0.key == destination})
        return multiplyConversion(value1: valueForBase, value2: (destinationFinded?.first?.value ?? 0))
    }
    
    func multiplyConversion(value1: Double, value2: Double) -> Double{
        return value1 * value2
    }
    
    func makeReversedCalcOfConversion(valueForDestination: Double) -> Double {
        let destinationFinded = latestExchange?.rates?.filter({$0.key == destination})

        return divisionConversion(value1: valueForDestination, value2: (destinationFinded?.first?.value ?? 0))
    }
    
    func divisionConversion(value1: Double, value2: Double) -> Double{
        return value1 / value2
    }
}
extension MainViewModel {
    enum Constants {
        static let defaultText = "-"
    }
}

extension MainViewModel {
    var baseCurrency: String {
        return latestExchange?.base ?? Constants.defaultText
    }
    
    var ratesKeys: [String]? {
        if let ratesKeys = latestExchange?.rates?.keys {
            return Array(ratesKeys)
        }
        return nil
    }
}
