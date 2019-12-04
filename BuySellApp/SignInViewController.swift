//
//  SignInViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/21/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signIn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.backgroundColor = UIColor(red: 0x28 / 0xFF, green: 0xA7 / 0xFF, blue: 0x45 / 0xFF, alpha: 1.0)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        segment.selectedSegmentIndex = 0
    }
    
    func segmentDidChange() {}
}
