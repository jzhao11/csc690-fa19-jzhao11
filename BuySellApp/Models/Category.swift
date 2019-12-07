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

class Category {
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
}
