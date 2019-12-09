//
//  SellingViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/20/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class SellingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var categories: [Category] = [Category(id: "", title: "")]
    var imagePath = ""
    var categoryId = ""
    var userId = ""
    let categoryDropDown = DropDown()
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postButton: UIButton!

    @IBAction func chooseCategory(_ sender: Any) {
        categoryDropDown.show()
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postItem(_ sender: Any) {
        let titleImage = imageView.image ?? UIImage.init()
        let title = titleTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let price = Double(priceTextField.text ?? "") ?? 0.0
        if (categoryId == "") {
            promptLabel.textColor = UIColor.systemRed
            promptLabel.text = "Missing Category"
            return
        } else if (titleImage == UIImage.init()) {
            promptLabel.textColor = UIColor.systemRed
            promptLabel.text = "Missing Title Image"
            return
        } else if (title == "") {
            promptLabel.textColor = UIColor.systemRed
            promptLabel.text = "Missing Title"
            return
        } else if (description == "") {
            promptLabel.textColor = UIColor.systemRed
            promptLabel.text = "Missing Description"
            return
        } else if (price <= 0.0) {
            promptLabel.textColor = UIColor.systemRed
            promptLabel.text = "Invalid Price"
            return
        }
        
        let urlToCreate = Item.getUrlToCreate()
        let params = [
            "user_id": userId,
            "category_id": categoryId,
            "title": title,
            "description": description,
            "price": String(format: "%.2f", price)
        ]
        createItem(url: urlToCreate, params: params, image: titleImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        imagePicker.delegate = self
        postButton.backgroundColor = CustomColor.successGreen
        postButton.setTitleColor(UIColor.white, for: .normal)
        
        // dropdown menu of categories
        categories.append(contentsOf: Category.getCurrentCategories())
        categoryDropDown.anchorView = view
        categoryDropDown.dataSource = categories.map {return $0.title}
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryId = self.categories[index].id
            self.categoryLabel.text = self.categories[index].title
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func createItem(url: String, params: [String: String], image: UIImage
//        , success: @escaping (_ response: Any?) -> (), failture : @escaping (_ error: Error) -> ()
    ) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                guard
                    let imageData = image.jpegData(compressionQuality: 1.0)
                else {
                    return
                }
                
                for (key, value) in params {
                    multipartFormData.append((value.data(using: String.Encoding.utf8)!), withName: key)
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let fileName = formatter.string(from: Date()) + ".jpg"
                multipartFormData.append(imageData, withName: "title_img", fileName: fileName, mimeType: "image/jpeg")
            },
            to: url,
            headers: nil,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            guard
                                let data = response.result.value
                            else {
                                return
                            }
                            
                            let jsonDict = JSON(data)
                            if (jsonDict["id"].stringValue != "") {
                                self.promptLabel.textColor = CustomColor.successGreen
                                self.promptLabel.text = "Success! Item Posted"
                            }
//                            print("item successfully created: \(response)")
//                            let result = response.result
//                            if (result.isSuccess) {success(response.value)}
                        }
                    case .failure(let encodingError):
//                        failture(encodingError)
                        print(encodingError)
                }
            }
        )
    }
}
