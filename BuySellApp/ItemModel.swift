//
//  ItemModel.swift
//  BuySellApp
//
//  Created by Mac on 11/19/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemModel: Hashable {
    let id: String
    let title: String
    let img: String
    let price: Double
    let description: String
    let seller: String
    let createdAt: String

    init(id: String, title: String, img: String, price: Double, description: String, seller: String, createdAt: String) {
        self.id = id
        self.title = title
        self.img = img
        self.price = price
        self.description = description
        self.seller = seller
        self.createdAt = createdAt
    }
    
    init(jsonDict: JSON) {
        self.id = jsonDict["id"].stringValue
        self.title = jsonDict["title"].stringValue
        self.img = jsonDict["title_img"].stringValue
        self.price = jsonDict["price"].doubleValue
        self.description = jsonDict["description"].stringValue
        self.seller = jsonDict["username"].stringValue
        self.createdAt = jsonDict["created_at"].stringValue
//        print("\(self.id);\(self.price);\(self.seller)")
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
    
    // Equatable
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}

