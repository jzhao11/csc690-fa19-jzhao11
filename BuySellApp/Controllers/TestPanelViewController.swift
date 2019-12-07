//
//  MyDashBoardViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/4/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

class TestPanelViewController: UIViewController {

    var currentPosition: Int = 0
    var buttons: [UIButton] = []
    let grayColor: UIColor = UIColor(red: 0xDD / 0xFF, green: 0xDD / 0xFF, blue: 0xDD / 0xFF, alpha: 1.0)
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @IBOutlet weak var myItemsButton: UIButton!
    @IBOutlet weak var myMessagesButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "username")
        performSegue(withIdentifier: "signOut", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myItemsViewController: MyItemsViewController = MyItemsViewController()
        let myMessagesViewController: MyMessagesViewController = MyMessagesViewController()
        myItemsViewController.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight + 500)
        myMessagesViewController.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        self.scrollView.addSubview(myItemsViewController.view)
        self.scrollView.addSubview(myMessagesViewController.view)
        self.scrollView.contentSize = CGSize(width: 2 * screenWidth, height: 0)
        
        buttons.append(myItemsButton)
        buttons.append(myMessagesButton)
        buttons[currentPosition].backgroundColor = grayColor
    }
    
    @IBAction func viewMyItems(_ sender: Any) {
        if currentPosition != 0 {
            buttons[currentPosition].backgroundColor = UIColor.white
            currentPosition = 0
            buttons[currentPosition].backgroundColor = grayColor
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    @IBAction func viewMyMessages(_ sender: Any) {
        if currentPosition != 1 {
            buttons[currentPosition].backgroundColor = UIColor.white
            currentPosition = 1
            buttons[currentPosition].backgroundColor = grayColor
            self.scrollView.setContentOffset(CGPoint(x: 1 * screenWidth, y: 0), animated: true)
        }
    }
}
