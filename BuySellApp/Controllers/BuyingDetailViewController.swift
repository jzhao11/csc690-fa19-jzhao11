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
    let nsAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
    
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
                self.titleImageView?.image = image?.resizeImage(CGSize: CGSize(width: 240, height: 180))
            }

            self.titleLabel.attributedText = self.formatAttributedText(str1: "Item:\n", str2: "\(item.title)")
            self.sellerLabel.attributedText = self.formatAttributedText(str1: "Seller:\n", str2: "\(item.seller)")
            self.priceLabel.attributedText = self.formatAttributedText(str1: "Price:\n", str2: "$\(item.price)")
            self.descriptionLabel.attributedText = self.formatAttributedText(str1: "Description:\n", str2: "\(item.description)")
            self.createdAtLabel.attributedText = self.formatAttributedText(str1: "Posted At:\n", str2: "\(item.createdAt)")
        }
    }
    
    func formatAttributedText(str1: String, str2: String) -> NSAttributedString {
        return concatStringsAsNSMutableAttributedString(str1: str1, str2: str2, attr1: nsAttributes, attr2: nil)
    }
    
    func concatStringsAsNSMutableAttributedString (str1: String, str2: String, attr1: [NSAttributedString.Key : Any]?, attr2: [NSAttributedString.Key : Any]?) -> NSAttributedString {
        let attrStr1 = NSMutableAttributedString(string: str1, attributes: attr1)
        let attrStr2 = NSMutableAttributedString(string: str2, attributes: attr2)
        attrStr1.append(attrStr2)
        return attrStr1
    }
}
