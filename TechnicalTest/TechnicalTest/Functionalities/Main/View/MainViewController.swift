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

    //  MARK: - IBOutlets and Variables
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localizable.titleMainView.localized
        }
    }
    /// Buttons to select currency
    @IBOutlet weak var baseCurrency: RoundedButton!
    @IBOutlet weak var destinationCurrency: RoundedButton!
    
    /// Value to present/change result of calcs
    @IBOutlet weak var baseCurrencyValue: UITextField!
        { didSet { baseCurrencyValue.text = "1.0" }}
    @IBOutlet weak var destinationCurrencyValue: UITextField!
    
    /// Orientation labels
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
    @IBOutlet weak var explanation: UILabel!

    /// Variables
    private var selectCurrencyOptions: (orientation: String, option: UIButton)?
    private var viewModel: MainViewModel!

    //MARK: - Father class methods
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel = MainViewModel(delegate: self)
        
        // Fectching latest without a base, to get base default from API.
        viewModel.fetchLatestExchange()
        
        styleTitleView()
        addToolbarOnTextFields()
    }
    
    //  MARK: - Actions
    /// This method whill performSegue for selecton of currency and select the correct title orientation.
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
    
    /// This method will remove keyboard with UIControl on Container View
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
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
        destinationCurrency.setTitle(viewModel.destination ?? Currencies.BRL.rawValue,
                                     for: .normal)
    }
    
    /// This method will apply the result of conversion
    func applyCalcOnView() {
        if let baseValue = Double(baseCurrencyValue.text ?? "1.0")?.rounded(toPlaces: 2) {
            let result = viewModel.makeCalcOfConversion(valueForBase: baseValue)
            destinationCurrencyValue.text = "\(result.rounded(toPlaces: 2))"
        }
    }
    
    /// This method will apply the result of conversion
    func applyReversedCalcOnView() {
        if let destinationValue = Double(destinationCurrencyValue.text ?? "1.0")?.rounded(toPlaces: 2) {
            let result = viewModel.makeReversedCalcOfConversion(valueForDestination: destinationValue)
            baseCurrencyValue.text = "\(result.rounded(toPlaces: 2))"
        }
    }
    
    /// This method apply style on titleLabel.
    func styleTitleView() {
        let attText = NSMutableAttributedString()
        attText.append(makeDinamicAttStringStyled(
                            text: Localizable.titleMainView.localized,
                            fontName: Fonts.futuraMedium,
                            color: Cores.black))
        
        attText.append(makeDinamicAttStringStyled(
                            text: Localizable.titleMainBoldPart.localized,
                            fontName: Fonts.futuraBold,
                            color: Cores.blue))
        
        titleLabel.attributedText = attText
    }
    
    /// This method mount the explanation text.
    func makeExplain() {
        guard let baseValue = baseCurrencyValue.text,
              let base = baseCurrency.titleLabel?.text,
              let destinationValue = destinationCurrencyValue.text,
              let destination = destinationCurrency.titleLabel?.text
        else {
                return
        }
        
        explanation.text = String(format: "%@ %@ (moeda base/origem) equivale a %@ %@ (moeda destino) e vice versa.", baseValue, base, destinationValue, destination)
    }
    
    /// This method add a toolBar on textFields to improve UX.
    func addToolbarOnTextFields() {
        let keyboardDoneButtonView = UIToolbar.init()
        keyboardDoneButtonView.sizeToFit()
        let doneButton = UIBarButtonItem.init(
                            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                            target: self,
                            action: #selector(textFieldShouldEndEditing(_:))
                         )

        keyboardDoneButtonView.items = [doneButton]
        baseCurrencyValue.inputAccessoryView = keyboardDoneButtonView
        destinationCurrencyValue.inputAccessoryView = keyboardDoneButtonView
    }
    
    /// This method mount a NSAttributedString with a font name and the selected color
    func makeDinamicAttStringStyled(text: String, fontName: String, color: UIColor) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        return NSAttributedString.init(string: text,
                attributes: [
                    NSAttributedString.Key.font : UIFont(name: fontName, size: 17) as Any,
                    NSAttributedString.Key.foregroundColor : color,
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
                self.makeExplain()
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

extension MainViewController: UITextFieldDelegate {
    /// This method will atualize calc and values
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if view.selectedTextField == destinationCurrencyValue {
            applyReversedCalcOnView()
        } else {
            applyCalcOnView()
        }
        dismissKeyboard()
        return true
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

