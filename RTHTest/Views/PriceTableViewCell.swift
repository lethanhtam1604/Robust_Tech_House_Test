//
//  PriceTableViewCell.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var dateLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!

    static let kCellId = "PriceTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func bindingDate(_ price: Price) {
        if let date = price.date {
            dateLabel.text = Utils.dateForShowing(string: date)
        } else {
            dateLabel.text = ""
        }

        if let amount = price.amount {
            priceLabel.text = "$" + amount
        } else {
            priceLabel.text = ""
        }
    }
}
