//
//  MovieUpcomingCell.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieUpcomingCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    
    func setImage(urlImage: String? ) {
        if let urlImage = urlImage{
            Alamofire.request(urlImage).responseImage { response in
                debugPrint(response)
                
                print(response.request!)
                print(response.response!)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    self.image.image = image
                }
                else
                {
                    self.image.image = #imageLiteral(resourceName: "placeholderImage")
                }
            }
        } else {
            image.image =  #imageLiteral(resourceName: "placeholderImage")
        }
    }
}
