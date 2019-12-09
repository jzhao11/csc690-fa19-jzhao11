//
//  MyItemsViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/4/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyItemsViewController: UITableViewController {
    
    var items: [Item] = []
    var userId = ""
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        dataSource = self
        delegate = self
        self.registerTableViewCells()
        let urlToReadByUser = Item.getUrlToReadByUser(userId: userId)
        loadItemsByUser(url: urlToReadByUser)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 125
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell", for: indexPath) as! ItemViewCell
        cell.titleLabel.attributedText = Item.formatAttributedText(str1: "Item: ", str2: "\(item.title)")
        cell.priceLabel.attributedText = Item.formatAttributedText(str1: "Price: ", str2: "$\(item.price)")
        cell.infoLabel.attributedText = Item.formatAttributedText(str1: "Posted At: ", str2: "\(item.createdAt.prefix(10))")
        
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
        let itemViewCell = UINib(nibName: "ItemViewCell", bundle: nil)
        self.tableView.register(itemViewCell, forCellReuseIdentifier: "ItemViewCell")
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
