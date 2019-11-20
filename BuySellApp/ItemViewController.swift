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

class ItemViewController: UIViewController {
    
    var items: [ItemModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        let url = "http://127.0.0.1:8888/buysell/api/item/readall"
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            if ((response.result.value) != nil) {
                let jsonArr = JSON(response.result.value!)
                for jsonDict in jsonArr.arrayValue {
                    self.items.append(ItemModel(jsonDict: jsonDict))
                }
            }
            print(self.items.count)
        }
    }
}

