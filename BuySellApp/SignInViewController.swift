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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.selectedSegmentIndex = 0
    }
    
    func segmentDidChange() {}
}
