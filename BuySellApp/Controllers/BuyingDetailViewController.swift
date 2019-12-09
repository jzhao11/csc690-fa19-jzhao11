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
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func sendMessage(_ sender: Any) {
        print(messageTextField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Item.getUrlToReadById(itemId: itemId)
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonDict = JSON(data)
            let item = Item(jsonDict: jsonDict)
            
            if
                let imagePath = URL(string: Model.getUrlToReadImage(imagePath: item.titleImage)),
                let data = try? Data(contentsOf: imagePath) {
                let image = UIImage(data: data)
                self.titleImageView?.image = image?.resizeImage(CGSize: CGSize(width: 240, height: 180))
            }

            self.titleLabel.attributedText = Model.formatAttributedText(str1: "Item:\n", str2: "\(item.title)")
            self.sellerLabel.attributedText = Model.formatAttributedText(str1: "Seller:\n", str2: "\(item.seller)")
            self.priceLabel.attributedText = Model.formatAttributedText(str1: "Price:\n", str2: "$\(item.price)")
            self.descriptionLabel.attributedText = Model.formatAttributedText(str1: "Description:\n", str2: "\(item.description)")
            self.createdAtLabel.attributedText = Model.formatAttributedText(str1: "Posted At:\n", str2: "\(item.createdAt)")
        }
        
        sendMessageButton.backgroundColor = CustomColor.warningYellow
        sendMessageButton.setTitleColor(UIColor.white, for: .normal)
    }
}
