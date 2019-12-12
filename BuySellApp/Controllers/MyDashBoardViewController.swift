//
//  MyDashBoardViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/7/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class MyDashBoardViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var myItemsButton: UIButton!
    @IBOutlet weak var myMessagesButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "username")
        performSegue(withIdentifier: "signOut", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        welcomeLabel.font = welcomeLabel.font.withSize(20)
        myItemsButton.titleLabel?.font = myItemsButton.titleLabel?.font.withSize(20)
        myMessagesButton.titleLabel?.font = myMessagesButton.titleLabel?.font.withSize(20)
        signOutButton.titleLabel?.font = signOutButton.titleLabel?.font.withSize(20)
        welcomeLabel.backgroundColor = CustomColor.lightGray
        myMessagesButton.backgroundColor = CustomColor.lightGray
        welcomeLabel.text = "Welcome \(username) \n\nThis is your dashboard."
    }
}
