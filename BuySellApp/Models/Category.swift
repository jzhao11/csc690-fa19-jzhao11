//
//  Category.swift
//  BuySellApp
//
//  Created by Mac on 12/5/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Category: Model {
    let id: String
    let title: String

    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    init(jsonDict: JSON) {
        self.id = jsonDict["id"].stringValue
        self.title = jsonDict["title"].stringValue
    }
    
    static func getCurrentCategories () -> [Category] {
        return [
            Category(id: "1", title: "Clothes"),
            Category(id: "20", title: "Entertainment"),
            Category(id: "9", title: "Books"),
            Category(id: "12", title: "Electronic Devices"),
            Category(id: "15", title: "Furniture"),
            Category(id: "33", title: "Fishes")
        ]
    }
}
