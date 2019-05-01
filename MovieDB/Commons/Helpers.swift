//
//  Helpers.swift
//  MovieDB
//
//  Created by Administrador on 30/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Helpers{
    static func setImage(urlImage: String? ) -> UIImage? {
        var returnImage: UIImage?
        if let urlImage = urlImage{
            Alamofire.request(urlImage).responseImage { response in
                if let image = response.result.value {
                    returnImage = image
                }
                else
                {
                    returnImage = #imageLiteral(resourceName: "placeholderImage")
                }
            }
        } else {
            returnImage =  #imageLiteral(resourceName: "placeholderImage")
        }
        return returnImage
    }
}
