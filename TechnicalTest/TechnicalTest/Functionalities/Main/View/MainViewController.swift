//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 24/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - IBOutlets and Variables
    @IBOutlet var baseCurrency: UIButton!
    @IBOutlet var destinationCurrency: UIButton!
    
    private var orientationToPresent: String?
    private var viewModel: MainViewModel!

    //MARK: - Father class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let langStr = Locale.current.languageCode
        
        viewModel = MainViewModel(delegate: self)
        viewModel.fetchLatestExchange()
    }
    
    //MARK: - Actions
    @IBAction func openSelectionOfCurrency(sender: UIButton) {
        switch sender {
        case baseCurrency:
            orientationToPresent = Localizable.orientationBaseExchange.localized
            break
        case destinationCurrency:
            orientationToPresent = Localizable.orientationDestinationExchange.localized
            break
        default:
            break
        }
        
        performSegue(withIdentifier: Constants.segueToSelectCurrency, sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectCurrencyViewController {
            destination.orientationText = orientationToPresent
        }
    }
}

private extension MainViewController {
    func reloadTexts() {
        baseCurrency.titleLabel?.text = viewModel.baseCurrency
    }
}

private extension MainViewController {
    private enum Localizable {
        static let orientationBaseExchange = "orientationExchangeBase.label"
        static let orientationDestinationExchange = "orientationExchangeConverted.label"
        
        static let errorTitle = "error.title"
    }
    
    private enum Constants {
        static let segueToSelectCurrency = "sendToSelectCurrency"
    }
}

extension MainViewController: MainViewModelDelegate {
    func loaded(state: State) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                self.reloadTexts()
            case .failed(let error):
                self.alert(title: Localizable.errorTitle.localized, message: error)
            }
        }
    }
}

