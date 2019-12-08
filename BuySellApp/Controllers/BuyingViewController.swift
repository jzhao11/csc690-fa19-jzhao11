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
    var categories: [Category] = [
        Category(id: "", title: ""),
        Category(id: "", title: "All")
    ]
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    let categoryDropDown = DropDown()

    @IBOutlet weak var categoryButton: UIButton!
        
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func showCategoryDropDown(_ sender: Any) {
        categoryDropDown.show()
    }

    @IBAction func searchItemsByKeyword(_ sender: Any) {
        let keyword = searchTextField.text ?? ""
        let urlToReadByKeyWord = Item.getUrlToReadByKeyword(keyword: keyword)
        loadItems(url: urlToReadByKeyWord)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        self.registerTableViewCells()
        let urlToReadAll = Item.getUrlToReadAll()
        loadItems(url: urlToReadAll)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 125

        // dropdown menu of categories
        categories.append(contentsOf: Category.getCurrentCategories())
        categoryDropDown.anchorView = view
        categoryDropDown.dataSource = categories.map {return $0.title}
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let categoryId = self.categories[index].id
            let urlToReadByCategory = Item.getUrlToReadByCategory(categoryId: categoryId)
            self.loadItems(url: urlToReadByCategory)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell", for: indexPath) as! ItemViewCell
        cell.titleLabel.attributedText = Model.formatAttributedText(str1: "Item: ", str2: "\(item.title)")
        cell.priceLabel.attributedText = Model.formatAttributedText(str1: "Price: ", str2: "$\(item.price)")
        cell.infoLabel.attributedText = Model.formatAttributedText(str1: "Seller: ", str2: "\(item.seller)")
        
        if
            let url = URL(string: Model.getUrlToReadImage(imagePath: item.titleImage)),
            let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            cell.imageView?.image = image?.resizeImage(CGSize: CGSize(width: 140
                , height: 105))
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
    
    func loadItems(url: String) {
        Alamofire.request(url, method: .get).responseJSON { (response) -> Void in
            guard
                let data = response.result.value
            else {
                return
            }
            
            self.items = []
            let jsonArr = JSON(data)
            for jsonDict in jsonArr.arrayValue {
                self.items.append(Item(jsonDict: jsonDict))
            }
            self.tableView.reloadData()
        }
    }
}
