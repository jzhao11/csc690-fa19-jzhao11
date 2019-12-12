//
//  Message.swift
//  BuySellApp
//
//  Created by Mac on 12/7/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Message: Model {
    let id: String
    let itemId: String
    let fromUserId: String
    let toUserId: String
    let fromUsername: String
    let toUsername: String
    let titleImage: String
    let title: String
    let price: Double
    let content: String
    let createdAt: String
    
    init(id: String, itemId: String, fromUserId: String, toUserId: String, fromUsername: String, toUsername: String, titleImage: String, title: String, price: Double, createdAt: String, content: String) {
        self.id = id
        self.itemId = itemId
        self.fromUserId = fromUserId
        self.toUserId = toUserId
        self.fromUsername = fromUsername
        self.toUsername = toUsername
        self.titleImage = titleImage
        self.title = title
        self.price = price
        self.content = content
        self.createdAt = createdAt
    }
    
    init(jsonDict: JSON) {
        self.id = jsonDict["id"].stringValue
        self.itemId = jsonDict["item_id"].stringValue
        self.fromUserId = jsonDict["from_user_id"].stringValue
        self.toUserId = jsonDict["to_user_id"].stringValue
        self.fromUsername = jsonDict["from_username"].stringValue
        self.toUsername = jsonDict["to_username"].stringValue
        self.titleImage = jsonDict["title_img"].stringValue
        self.title = jsonDict["title"].stringValue
        self.price = jsonDict["price"].doubleValue
        self.content = jsonDict["content"].stringValue
        self.createdAt = jsonDict["created_at"].stringValue
    }
    
    static func getUrlToReadByUser(userId: String) -> String {
        return commonUrl + "api/message/readbyuser?userid=" + userId
    }
    
    static func getUrlToCreate() -> String {
        return commonUrl + "api/message/create"
    }
    
    static func getUrlToReadById(messageId: String) -> String {
        return commonUrl + "api/message/readbyid?id=" + messageId
    }
}
