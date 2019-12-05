//
//  MyDashBoardViewController.swift
//  BuySellApp
//
//  Created by Mac on 12/4/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

class MyDashBoardViewController: UIViewController {

    @IBOutlet weak var myItemsButton: UIButton!
    @IBOutlet weak var myMessagesButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var currentPosition = 0
    var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let myItemsViewController: MyItemsViewController = MyItemsViewController()
        let myMessagesViewController: MyMessagesViewController = MyMessagesViewController()
        myItemsViewController.view.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        myMessagesViewController.view.frame = CGRect(x: screen_width, y: 0, width: screen_width, height: screen_height)
        self.scrollView.addSubview(myItemsViewController.view)
        self.scrollView.addSubview(myMessagesViewController.view)
        self.scrollView.contentSize = CGSize(width: 2 * screen_width, height: 0)
        
        buttons.append(myItemsButton)
        buttons.append(myMessagesButton)
        buttons[currentPosition].backgroundColor = UIColor.gray
    }
    
    @IBAction func viewMyItems(_ sender: Any) {
        if currentPosition != 0 {
            buttons[currentPosition].backgroundColor = UIColor.white
            currentPosition = 0
            buttons[currentPosition].backgroundColor = UIColor.gray
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    @IBAction func viewMyMessages(_ sender: Any) {
        if currentPosition != 1 {
            buttons[currentPosition].backgroundColor = UIColor.white
            currentPosition = 1
            buttons[currentPosition].backgroundColor = UIColor.gray
            self.scrollView.setContentOffset(CGPoint(x: 1 * screen_width, y: 0), animated: true)
        }
    }
}
