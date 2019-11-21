//
//  SellingViewController.swift
//  BuySellApp
//
//  Created by Mac on 11/20/19.
//  Copyright © 2019 Christian Zhao. All rights reserved.
//

import UIKit
import Alamofire

class SellingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func postItem(_ sender: Any) {
        let url = "http://127.0.0.1:8888/buysell/api/item/create"
        let params = [
            "user": "123",
            "title": "Mac Mini"
        ]
        let image = imageView.image
        upload(url: url, params: params, image: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "MacMini")
    }
    
    func upload(url: String, params: [String: String]?, image: UIImage?
//        , success: @escaping (_ response: Any?) -> (), failture : @escaping (_ error: Error) -> ()
    ) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                guard
                    let arrData = params,
                    let imageData = image?.jpegData(compressionQuality: 1.0)
                else {
                    return
                }
                
                for (key, value) in arrData {
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
                            print("response = \(response)")
                            let result = response.result
                            if result.isSuccess {
//                                success(response.value)
                            }
                        }
                    case .failure(let encodingError):
//                        failture(encodingError)
                        print(encodingError)
                }
            }
        )
    }
}
