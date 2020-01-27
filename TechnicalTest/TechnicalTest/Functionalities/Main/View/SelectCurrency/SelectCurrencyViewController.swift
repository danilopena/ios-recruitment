//
//  SelectCurrencyViewController.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 26/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class SelectCurrencyViewController: UIViewController {

    //MARK: - IBOutlets and Variables
    @IBOutlet weak var viewContainer: UIView! {
        didSet {
            viewContainer.layer.cornerRadius = 5
            viewContainer.layer.borderWidth = 1
            viewContainer.layer.borderColor = Cores.blue.cgColor
        }
    }
    @IBOutlet weak var orientationTitle: UILabel! {
        didSet {
            orientationTitle.text = selectCurrencyOptions?.orientation
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    var selectCurrencyOptions: (orientation: String, option: UIButton)?
    var delegateMainView: MainViewControllerDelegate!
    var rates: [String]? {
        didSet {
            rates = rates?.sorted { $0 < $1 }
        }
    }
    
    //MARK: - Father class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
    }
    
    //MARK: - Actions
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectCurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? CurrencyCell {
            if let currencyEnum = Currencies(rawValue: rates?[indexPath.row] ?? Constants.unknownOption) {
                cell.configure(text: currencyEnum.rawValue + " - " + currencyEnum.nameOfCountryOrCity())
            }
            
            return cell
        }
            
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tupleInfos = selectCurrencyOptions,
            let rateSelected = rates?[indexPath.row] else {
                return
        }
        
        self.dismiss(animated: true) {
            self.delegateMainView.reloadAll(button: tupleInfos.option, selectedOption: rateSelected)
        }
    }
}

extension SelectCurrencyViewController {
    private enum Constants {
        static let cellIdentifier = "cell"
        static let unknownOption = "UNK"
    }
}
