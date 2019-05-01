//
//  MovieDBImage.swift
//  MovieDB
//
//  Created by Administrador on 30/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromRemote(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if let currentData = data {
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: currentData)
                    self.image = image
                })
            }
            else
            {
                self.image = #imageLiteral(resourceName: "placeholderImage")
            }
        }).resume()
    }
}
