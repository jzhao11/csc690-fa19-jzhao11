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
    
    var itemId = ""
    var toUserId = ""
    var fromUserId = ""
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBAction func sendMessage(_ sender: Any) {
        let message = messageTextField.text ?? ""
        if (message == "") {
            promptLabel.textColor = UIColor.systemRed
            promptLabel.text = "Empty Message"
            return
        }
        
        let urlToCreate = Message.getUrlToCreate()
        let params = [
            "item_id": itemId,
            "to_user_id": toUserId,
            "from_user_id": fromUserId,
            "content": message
        ]
        Alamofire.request(urlToCreate, method: .post, parameters: params as Parameters).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonDict = JSON(data)
            if (jsonDict["id"].stringValue != "") {
                self.promptLabel.textColor = CustomColor.successGreen
                self.promptLabel.text = "Success! Message Sent"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromUserId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let urlToReadById = Item.getUrlToReadById(itemId: itemId)
        loadItem(url: urlToReadById)
        sendMessageButton.backgroundColor = CustomColor.warningYellow
        sendMessageButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func loadItem(url: String) {
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
    }
}
