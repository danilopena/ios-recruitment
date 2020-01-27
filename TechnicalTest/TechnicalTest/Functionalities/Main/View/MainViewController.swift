//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 24/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate {
    func reloadAll(button: UIButton, selectedOption: String)
}

class MainViewController: UIViewController {

    //MARK: - IBOutlets and Variables
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localizable.titleMainView.localized
        }
    }
    // Buttons to select currency
    @IBOutlet weak var baseCurrency: RoundedButton!
    @IBOutlet weak var destinationCurrency: RoundedButton!
    
    // Value to present/change result of calcs
    @IBOutlet weak var baseCurrencyValue: UITextField!
        { didSet { baseCurrencyValue.text = "1.0" }}
    @IBOutlet weak var destinationCurrencyValue: UITextField!
    
    // Orientation labels
    @IBOutlet weak var orientationBase: UILabel! {
        didSet {
            orientationBase.text = Localizable.orientationBaseExchange.localized
        }
    }
    @IBOutlet weak var orientationDestination: UILabel! {
        didSet {
            orientationDestination.text = Localizable.orientationDestinationExchange.localized
        }
    }

    // Variables
    private var selectCurrencyOptions: (orientation: String, option: UIButton)?
    private var viewModel: MainViewModel!

    //MARK: - Father class methods
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel = MainViewModel(delegate: self)
        viewModel.fetchLatestExchange()
        
        styleTitleView()
    }
    
    //MARK: - Actions
    @IBAction func openSelectionOfCurrency(sender: UIButton) {
        switch sender {
        case baseCurrency:
            selectCurrencyOptions = (Localizable.orientationBaseExchange.localized, baseCurrency)
            break
        case destinationCurrency:
            selectCurrencyOptions = (Localizable.orientationDestinationExchange.localized, destinationCurrency)
            break
        default:
            break
        }
        
        performSegue(withIdentifier: Constants.segueToSelectCurrency, sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectCurrencyViewController {
            destination.selectCurrencyOptions = selectCurrencyOptions
            destination.rates = viewModel.ratesKeys
            destination.delegateMainView = self
        }
    }
}

private extension MainViewController {

    func reloadTextsOfCurrencies() {
        baseCurrency.setTitle(viewModel.baseCurrency, for: .normal)
        destinationCurrency.setTitle(viewModel.destination ?? Currencies.BRL.rawValue, for: .normal)
    }
    
    // This method will apply the result of conversion
    func applyCalcOnView() {
        if let baseValue = Double(baseCurrencyValue.text ?? "1.0") {
            let result = viewModel.makeCalcOfConversion(valueForBase: baseValue)
            destinationCurrencyValue.text = "\(result)"
        }
    }
    
    // This method apply style on titleLabel.
    func styleTitleView() {
        let attText = NSMutableAttributedString()
        attText.append(makeDinamicAttMediumBold(text: Localizable.titleMainView.localized))
        attText.append(makeDinamicAttStringBold(text: Localizable.titleMainBoldPart.localized))
        
        titleLabel.attributedText = attText
    }
    
    func makeDinamicAttStringBold(text: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        return NSAttributedString.init(string: text
            , attributes: [
                NSAttributedString.Key.font : UIFont(name: "Futura-Bold", size: 17) as Any,
                NSAttributedString.Key.foregroundColor : Cores.blue,
                NSAttributedString.Key.paragraphStyle : paragraph
            ])
    }
    
    func makeDinamicAttMediumBold(text: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        return NSAttributedString.init(string: text
            , attributes: [
                NSAttributedString.Key.font : UIFont(name: "Futura-Medium", size: 17) as Any,
                NSAttributedString.Key.foregroundColor : Cores.black,
                NSAttributedString.Key.paragraphStyle : paragraph
            ])
    }
}

extension MainViewController: MainViewModelDelegate {
    func loaded(state: State) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                self.reloadTextsOfCurrencies()
                self.applyCalcOnView()
            case .failed(let error):
                self.alert(title: Localizable.errorTitle.localized, message: error)
            }
        }
    }
}

extension MainViewController: MainViewControllerDelegate {
    func reloadAll(button: UIButton, selectedOption: String) {
        button.setTitle(selectedOption, for: .normal)
        if button == destinationCurrency {
            viewModel.destination = selectedOption
        }
        viewModel.fetchLatestExchange(baseCurrency.titleLabel?.text)
    }
}

// MARK: - Localizables and Constants
private extension MainViewController {
    private enum Localizable {
        static let titleMainView = "title.mainView"
        static let titleMainBoldPart = "title.boldPart"

        static let orientationBaseExchange = "orientationExchangeBase.label"
        static let orientationDestinationExchange = "orientationExchangeConverted.label"
        
        static let errorTitle = "error.title"
    }
    
    private enum Constants {
        static let segueToSelectCurrency = "sendToSelectCurrency"
    }
}

