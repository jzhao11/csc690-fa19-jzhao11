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
    
    var items: [Item] = []
    var userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        self.registerTableViewCells()
        let urlToReadByUser = Item.getUrlToReadByUser(userId: userId)
        loadItemsByUser(url: urlToReadByUser)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell", for: indexPath) as! MessageViewCell
        cell.fromUserLabel.attributedText = Item.formatAttributedText(str1: "From: ", str2: "\(item.title)")
        cell.toUserLabel.attributedText = Item.formatAttributedText(str1: "To: ", str2: "\(item.price)")
        cell.infoLabel.attributedText = Item.formatAttributedText(str1: "Sent At: ", str2: "\(item.createdAt.prefix(10))")
        
        if
            let url = URL(string: Item.getUrlToReadImage(imagePath: item.titleImage)),
            let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            cell.imageView?.image = image?.resizeImage(CGSize: CGSize(width: 140
                , height: 105))
        }
        
        return cell
    }
    
    func registerTableViewCells() {
        let itemViewCell = UINib(nibName: "MessageViewCell", bundle: nil)
        self.tableView.register(itemViewCell, forCellReuseIdentifier: "MessageViewCell")
    }
    
    func loadItemsByUser(url: String) {
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            self.items = []
            let jsonArr = JSON(data)
            for jsonDict in jsonArr.arrayValue {
                self.items.append(Item(jsonDict: jsonDict))
            }
            self.tableView.reloadData()
        }
    }
}
