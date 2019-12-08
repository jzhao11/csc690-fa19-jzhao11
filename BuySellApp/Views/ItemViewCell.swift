//
//  MyTableViewCell.swift
//  BuySellApp
//
//  Created by Mac on 11/22/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
