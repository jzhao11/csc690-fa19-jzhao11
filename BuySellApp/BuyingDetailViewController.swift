//
//  BuyingDetailViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/20/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BuyingDetailViewController: UIViewController {
    
    var itemId: String = ""
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://127.0.0.1:8888/buysell/api/item/readbyid?id=\(itemId)"
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonDict = JSON(data)
            let item = Item(jsonDict: jsonDict)
            
            if
                let url = URL(string: Item.getUrlToReadImage(imagePath: item.titleImage)),
                let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                self.titleImageView?.image = image?.resizeImage(CGSize: CGSize(width: 300, height: 240))
            }
            
            self.titleLabel.text = "Item: \(item.title)"
            self.sellerLabel.text = "Seller: \(item.seller)"
            self.priceLabel.text = "Price: $\(item.price)"
            self.descriptionLabel.text = "Description: \(item.description)"
            self.createdAtLabel.text = "Posted At: \(item.createdAt)"
        }
    }
}
