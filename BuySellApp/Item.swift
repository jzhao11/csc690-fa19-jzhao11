//
//  Item.swift
//  BuySellApp
//
//  Created by Mac on 11/19/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Item {
    let id: String
    let title: String
    let titleImage: String
    let price: Double
    let description: String
    let seller: String
    let createdAt: String

    init(id: String, title: String, img: String, price: Double, description: String, seller: String, createdAt: String) {
        self.id = id
        self.title = title
        self.titleImage = img
        self.price = price
        self.description = description
        self.seller = seller
        self.createdAt = createdAt
    }
    
    init(jsonDict: JSON) {
        self.id = jsonDict["id"].stringValue
        self.title = jsonDict["title"].stringValue
        self.titleImage = jsonDict["title_img"].stringValue
        self.price = jsonDict["price"].doubleValue
        self.description = jsonDict["description"].stringValue
        self.seller = jsonDict["username"].stringValue
        self.createdAt = jsonDict["created_at"].stringValue
    }
}

