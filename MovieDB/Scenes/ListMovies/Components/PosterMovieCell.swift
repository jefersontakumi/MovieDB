//
//  PosterMovieCell.swift
//  MovieDB
//
//  Created by Administrador on 26/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PosterMovieCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    
    func setImage(urlImage: String? ) {
        if let urlImage = urlImage{
            Alamofire.request(urlImage).responseImage { response in
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
