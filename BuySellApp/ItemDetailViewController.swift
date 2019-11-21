//
//  ItemDetailViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/20/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ItemDetailViewController: UIViewController {
    
    var itemId: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let url = "http://127.0.0.1:8888/buysell/api/item/readbyid?id=\(itemId)"
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            let jsonDict = JSON(data)
            let item = Item(jsonDict: jsonDict);
            self.titleLabel.text = item.title
            self.sellerLabel.text = item.seller
            self.priceLabel.text = "$ \(item.price)"
        }
    }
}
