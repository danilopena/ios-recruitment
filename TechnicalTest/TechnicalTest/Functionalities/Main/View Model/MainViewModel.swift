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
    private(set) var rates: LatestListOfCurrencies?
    
    init(delegate: MainViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchLatestExchange() {
        ExchangeService<LatestListOfCurrencies>().fetchLatest(completion: {
            [weak self] response in
            guard let self = self else { return }
            self.rates = response
            self.delegate?.loaded(state: .success)
        }, error: {message in
            self.delegate?.loaded(state: .failed(error: message))
        })
    }
}
private extension MainViewModel {
    private enum Constants {
        static let defaultQuestionText = "-"
    }
}

extension MainViewModel {
    var baseCurrency: String {
        return rates?.base ?? Constants.defaultQuestionText
    }
}
