//
//  CurrencyCell.swift
//  TechnicalTest
//
//  Created by Danilo Pena on 27/01/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(text: String) {
        self.textLabel?.text = text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    private func reset() {
        self.textLabel?.text = nil
    }
}
