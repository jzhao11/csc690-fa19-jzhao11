//
//  Model.swift
//  BuySellApp
//
//  Created by Mac on 12/7/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import Foundation
import Alamofire

class Model {
    static let commonUrl: String = "http://127.0.0.1:8888/buysell/"
    static let modelNSAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    
    static func getUrlToReadImage(imagePath: String) -> String {
        return commonUrl + imagePath
    }
    
    static func formatAttributedText(str1: String, str2: String) -> NSAttributedString {
        return concatStringsAsNSMutableAttributedString(str1: str1, str2: str2, attr1: modelNSAttributes, attr2: nil)
    }
    
    static func concatStringsAsNSMutableAttributedString (str1: String, str2: String, attr1: [NSAttributedString.Key : Any]?, attr2: [NSAttributedString.Key : Any]?) -> NSAttributedString {
        let attrStr1 = NSMutableAttributedString(string: str1, attributes: attr1)
        let attrStr2 = NSMutableAttributedString(string: str2, attributes: attr2)
        attrStr1.append(attrStr2)
        return attrStr1
    }
}
