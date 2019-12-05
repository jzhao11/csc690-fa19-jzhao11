//
//  BuyingViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/22/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class BuyingViewController: UITableViewController {

    var items: [Item] = []
    var itemId: String = ""
    let categoryDropDown = DropDown()

    @IBOutlet weak var categoryButton: UIButton!
    
    @IBAction func showCategoryDropDown(_ sender: Any) {
        categoryDropDown.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        let url = "http://127.0.0.1:8888/buysell/api/item/readall"
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonArr = JSON(data)
            for jsonDict in jsonArr.arrayValue {
                self.items.append(Item(jsonDict: jsonDict))
            }
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        // dropdown menu of categories
        categoryDropDown.anchorView = view
        categoryDropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell", for: indexPath) as! ItemViewCell
        cell.titleLabel.text = "Item: \(item.title)"
        cell.sellerLabel.text = "Seller: \(item.seller)"
        cell.priceLabel.text = "Price: $\(item.price)"
        
        if
            let url = URL(string: "http://127.0.0.1:8888/buysell/\(item.titleImage)"),
            let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
//            cell.imageView?.image = image
            cell.imageView?.image = image?.resizeImage(CGSize: CGSize(width: 125, height: 100))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            indexPath.row < items.count
        else {
            return
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextPage = storyBoard.instantiateViewController(withIdentifier: "BuyingDetailViewController") as! BuyingDetailViewController
        nextPage.itemId = items[indexPath.row].id
        self.navigationController?.pushViewController(nextPage, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let buyingDetailViewController = segue.destination as? BuyingDetailViewController
        else {
            return
        }
        
        buyingDetailViewController.itemId = itemId
    }
    
    func registerTableViewCells() {
        let itemViewCell = UINib(nibName: "ItemViewCell", bundle: nil)
        self.tableView.register(itemViewCell, forCellReuseIdentifier: "ItemViewCell")
    }
    
    func loadData() {
        let url = "http://127.0.0.1:8888/buysell/api/item/readall"
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            let jsonArr = JSON(data)
            for jsonDict in jsonArr.arrayValue {
                self.items.append(Item(jsonDict: jsonDict))
            }
            self.tableView.reloadData()
        }
    }
}

extension UIImage {
    func resizeImage(CGSize : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: CGSize.width, height: CGSize.height))
        let resizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
