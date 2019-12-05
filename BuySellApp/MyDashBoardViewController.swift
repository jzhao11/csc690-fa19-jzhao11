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

    var currentPosition = 0

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let myItemsViewController: MyItemsViewController = MyItemsViewController()
        let myMessagesViewController: MyMessagesViewController = MyMessagesViewController()
        myItemsViewController.view.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        myMessagesViewController.view.frame = CGRect(x: screen_width, y: 0, width: screen_width, height: screen_height)
        self.scrollView.addSubview(myItemsViewController.view)
        self.scrollView.addSubview(myMessagesViewController.view)
        self.scrollView.contentSize = CGSize(width: 2 * screen_width, height: 0)
    }
    
    @IBAction func myItemsButton(_ sender: Any) {
        if currentPosition != 0 {
            currentPosition = 0
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    @IBAction func myMessagesButton(_ sender: Any) {
        if currentPosition != 1 {
            currentPosition = 1
            self.scrollView.setContentOffset(CGPoint(x: 1 * screen_width, y: 0), animated: true)
        }
    }
}
