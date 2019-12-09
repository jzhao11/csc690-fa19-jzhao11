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
    
    var urlToSignIn = ""
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func changeSegment(_ sender: Any) {
        promptLabel.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        if (segmentControl.selectedSegmentIndex == 0) {
            signInButton.setTitle("Sign In", for: UIControl.State.normal)
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            urlToSignIn = Model.commonUrl + "api/user/signin"
        } else {
            signInButton.setTitle("Register", for: UIControl.State.normal)
            confirmPasswordLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            urlToSignIn = Model.commonUrl + "api/user/register"
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        promptLabel.textColor = UIColor.systemRed
        if (username == "") {
            promptLabel.text = "Missing Username"
            return
        } else if (password == "") {
            promptLabel.text = "Missing Password"
            return
        }
        
        let params = [
            "username": username,
            "password": password,
            "confirm_password": confirmPassword
        ]
        Alamofire.request(urlToSignIn, method: .post, parameters: params as Parameters).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonDict = JSON(data)
            if (self.segmentControl.selectedSegmentIndex == 0) {
                if (jsonDict["id"].stringValue != "") {
                    UserDefaults.standard.set(jsonDict["id"].stringValue, forKey: "userId")
                    UserDefaults.standard.set(jsonDict["username"].stringValue, forKey: "username")
                    self.performSegue(withIdentifier: "signIn", sender: self)
                } else {
                    self.promptLabel.textColor = UIColor.systemRed
                    self.promptLabel.text = jsonDict.stringValue
                }
            } else {
                if (jsonDict["id"].stringValue != "") {
                    self.segmentControl.selectedSegmentIndex = 0
                    self.changeSegment(self)
                    self.promptLabel.textColor = UIColor.systemGreen
                    self.promptLabel.text = "Success! Please Sign In"
                } else {
                    self.promptLabel.textColor = UIColor.systemRed
                    self.promptLabel.text = jsonDict.stringValue
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.selectedSegmentIndex = 0
        urlToSignIn = Model.commonUrl + "api/user/signin"
        confirmPasswordLabel.isHidden = true
        confirmPasswordTextField.isHidden = true
        promptLabel.textAlignment = NSTextAlignment.center
        signInButton.backgroundColor = CustomColor.successGreen
        signInButton.setTitleColor(UIColor.white, for: .normal)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
}
