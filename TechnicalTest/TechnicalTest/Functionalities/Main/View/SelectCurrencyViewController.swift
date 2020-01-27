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
            orientationTitle.text = orientationText
        }
    }
    var orientationText: String?
    
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
