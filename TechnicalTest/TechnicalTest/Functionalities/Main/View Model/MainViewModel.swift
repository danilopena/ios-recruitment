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
    private(set) var latestExchange: LatestListOfCurrencies?
    var destination: String?
    
    init(delegate: MainViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchLatestExchange(_ base: String? = nil) {
        ExchangeService<LatestListOfCurrencies>().fetchLatest(base: base, completion: {
            [weak self] response in
            guard let self = self else { return }
            self.latestExchange = response
            self.delegate?.loaded(state: .success)
        }, error: {message in
            self.delegate?.loaded(state: .failed(error: message))
        })
    }
    
    func makeCalcOfConversion(valueForBase: Double) -> Double {
        if destination == nil {
            destination = Currencies.BRL.rawValue
        }
        
        let destinationFinded = latestExchange?.rates?.filter({$0.key == destination})
        return valueForBase * (destinationFinded?.first?.value ?? 0)
    }
}
private extension MainViewModel {
    private enum Constants {
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
