//
//  MessageDetailViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/7/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessageDetailViewController: UIViewController {
    
    var messageId = ""
    var itemId = ""
    var fromUserId = ""
    var toUserId = ""
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    
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
        let myId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let urlToReadById = Message.getUrlToReadById(messageId: messageId)
        loadMessage(url: urlToReadById)
        sendMessageButton.backgroundColor = CustomColor.warningYellow
        sendMessageButton.setTitleColor(UIColor.white, for: .normal)
        if (fromUserId != myId) {
            toLabel.isHidden = true
            messageTextField.isHidden = true
            sendMessageButton.isHidden = true
        }
    }
    
    func loadMessage(url: String) {
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonDict = JSON(data)
            let message = Message(jsonDict: jsonDict)
            if
                let imagePath = URL(string: Model.getUrlToReadImage(imagePath: message.titleImage)),
                let data = try? Data(contentsOf: imagePath) {
                let image = UIImage(data: data)
                self.titleImageView?.image = image?.resizeImage(CGSize: CGSize(width: 240, height: 180))
            }

            self.titleLabel.attributedText = Model.formatAttributedText(str1: "Item:\n", str2: "\(message.title)")
            self.priceLabel.attributedText = Model.formatAttributedText(str1: "Price:\n", str2: "$\(message.price)")
            self.createdAtLabel.attributedText = Model.formatAttributedText(str1: "Sent At:\n", str2: "\(message.createdAt)")
            self.fromLabel.attributedText = Model.formatAttributedText(str1: "\(message.fromUsername) -> \(message.toUsername)\n", str2: "\(message.content)")
            self.toLabel.attributedText = Model.formatAttributedText(str1: "\(message.toUsername) -> \(message.fromUsername)", str2: "")
        }
    }
}
