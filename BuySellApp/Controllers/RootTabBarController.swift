//
//  RootTabBarController.swift
//  BuySellApp
//
//  Created by Mac on 12/5/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
}

extension UIImage {
    func resizeImage(CGSize : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: CGSize.width, height: CGSize.height))
        let resizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
