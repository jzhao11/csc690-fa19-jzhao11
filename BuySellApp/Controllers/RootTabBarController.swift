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
