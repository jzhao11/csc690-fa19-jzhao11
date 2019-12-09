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

class Item: Model {
    let id: String
    let userId: String
    let title: String
    let titleImage: String
    let price: Double
    let description: String
    let seller: String
    let createdAt: String

    init(id: String, userId: String, title: String, titleImage: String, price: Double, description: String, seller: String, createdAt: String) {
        self.id = id
        self.userId = userId
        self.title = title
        self.titleImage = titleImage
        self.price = price
        self.description = description
        self.seller = seller
        self.createdAt = createdAt
    }
    
    init(jsonDict: JSON) {
        self.id = jsonDict["id"].stringValue
        self.userId = jsonDict["user_id"].stringValue
        self.title = jsonDict["title"].stringValue
        self.titleImage = jsonDict["title_img"].stringValue
        self.price = jsonDict["price"].doubleValue
        self.description = jsonDict["description"].stringValue
        self.seller = jsonDict["username"].stringValue
        self.createdAt = jsonDict["created_at"].stringValue
    }
    
    static func getUrlToReadAll() -> String {
        return commonUrl + "api/item/readall"
    }
    
    static func getUrlToReadById(itemId: String) -> String {
        return commonUrl + "api/item/readbyid?id=" + itemId
    }
    
    static func getUrlToReadByCategory(categoryId: String) -> String {
        return commonUrl + "api/item/readbycategory?categoryid=" + categoryId
    }
    
    static func getUrlToReadByUser(userId: String) -> String {
        return commonUrl + "api/item/readbyuser?userid=" + userId
    }
    
    static func getUrlToReadByKeyword(keyword: String) -> String {
        return commonUrl + "api/item/readbykeyword?keyword=" + keyword
    }
    
    static func getUrlToCreate() -> String {
        return commonUrl + "api/item/create"
    }
}

