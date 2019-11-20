//
//  ItemViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/19/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var items: [ItemModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://127.0.0.1:8888/buysell/api/item/readall"
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard let data = response.result.value else {
                return
            }
            
            let jsonArr = JSON(data)
            for jsonDict in jsonArr.arrayValue {
                self.items.append(ItemModel(jsonDict: jsonDict))
            }
            print(self.items.count)
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(item.title);\(item.price)"
        if
            let url = URL(string: "http://127.0.0.1:8888/buysell/\(item.img)"),
            let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            cell.imageView?.image = image
        }
        return cell
    }
}
