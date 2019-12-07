//
//  MyDashBoardViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/7/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class MyDashBoardViewController: UIViewController {
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "username")
        performSegue(withIdentifier: "signOut", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
