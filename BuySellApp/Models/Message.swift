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
    let fromUsername: String
    let toUsername: String
    let titleImage: String
    let content: String
    let createdAt: String
    
    init(id: String, fromUsername: String, toUsername: String, titleImage: String, createdAt: String, content: String) {
        self.id = id
        self.fromUsername = fromUsername
        self.toUsername = toUsername
        self.titleImage = titleImage
        self.content = content
        self.createdAt = createdAt
    }
    
    init(jsonDict: JSON) {
        self.id = jsonDict["id"].stringValue
        self.fromUsername = jsonDict["from_username"].stringValue
        self.toUsername = jsonDict["to_username"].stringValue
        self.titleImage = jsonDict["title_img"].stringValue
        self.content = jsonDict["content"].stringValue
        self.createdAt = jsonDict["created_at"].stringValue
    }
    
    static func getUrlToReadByUser(userId: String) -> String {
        return commonUrl + "api/message/readbyuser?userid=" + userId
    }
}
