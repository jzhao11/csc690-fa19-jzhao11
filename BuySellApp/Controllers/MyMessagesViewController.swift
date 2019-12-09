//
//  MyMessagesViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/4/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyMessagesViewController: UITableViewController {
    
    var messages: [Message] = []
    var messageId = ""
    var userId = ""
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        dataSource = self
        delegate = self
        self.registerTableViewCells()
        let urlToReadByUser = Message.getUrlToReadByUser(userId: userId)
        loadMessagesByUser(url: urlToReadByUser)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell", for: indexPath) as! MessageViewCell
        cell.fromUserLabel.attributedText = Model.formatAttributedText(str1: "From: ", str2: "\(message.fromUsername)")
        cell.toUserLabel.attributedText = Model.formatAttributedText(str1: "To: ", str2: "\(message.toUsername)")
        cell.infoLabel.attributedText = Model.formatAttributedText(str1: "Sent At: ", str2: "\(message.createdAt.prefix(10))")
        cell.messageLabel.attributedText = Model.formatAttributedText(str1: "Message:\n", str2: "\(message.content)")
        
        if
            let imagePath = URL(string: Model.getUrlToReadImage(imagePath: message.titleImage)),
            let data = try? Data(contentsOf: imagePath) {
            let image = UIImage(data: data)
            cell.imageView?.image = image?.resizeImage(CGSize: CGSize(width: 140
                , height: 105))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            indexPath.row < messages.count
        else {
            return
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextPage = storyBoard.instantiateViewController(withIdentifier: "MessageDetailViewController") as! MessageDetailViewController
        nextPage.messageId = messages[indexPath.row].id
        self.navigationController?.pushViewController(nextPage, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let messageDetailViewController = segue.destination as? MessageDetailViewController
        else {
            return
        }
        
        messageDetailViewController.messageId = messageId
    }
    
    func registerTableViewCells() {
        let itemViewCell = UINib(nibName: "MessageViewCell", bundle: nil)
        self.tableView.register(itemViewCell, forCellReuseIdentifier: "MessageViewCell")
    }
    
    func loadMessagesByUser(url: String) {
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            self.messages = []
            let jsonArr = JSON(data)
            for jsonDict in jsonArr.arrayValue {
                self.messages.append(Message(jsonDict: jsonDict))
            }
            self.tableView.reloadData()
        }
    }
}
