//
//  MessageViewCell.swift
//  BuySellApp
//
//  Created by Mac on 12/7/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var fromUserLabel: UILabel!
    @IBOutlet weak var toUserLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
