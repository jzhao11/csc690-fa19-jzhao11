//
//  SignInViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/21/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signIn(_ sender: Any) {
        let url = "http://127.0.0.1:8888/buysell/api/user/signin"
        let params = [
            "username": usernameTextField.text ?? "",
            "password": passwordTextField.text ?? ""
        ]
        Alamofire.request(url, method: .post, parameters: params as Parameters).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonDict = JSON(data)
            if jsonDict["id"].stringValue != "" {
                UserDefaults.standard.set(jsonDict["id"].stringValue, forKey: "userId")
                UserDefaults.standard.set(jsonDict["username"].stringValue, forKey: "username")
                self.performSegue(withIdentifier: "signIn", sender: self)
            } else {
                print(jsonDict)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.backgroundColor = UIColor(red: 0x28 / 0xFF, green: 0xA7 / 0xFF, blue: 0x45 / 0xFF, alpha: 1.0)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        segment.selectedSegmentIndex = 0
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    func segmentDidChange() {}
}
