//
//  Company.swift
//  MovieDB
//
//  Created by Administrador on 30/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

struct Company: Codable {
    var id: Int
    var logo_path: String?
    var name: String
    var origin_country: String
}
