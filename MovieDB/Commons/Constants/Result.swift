//
//  Result.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

enum Result<E> where E:Error {
    case success(data: Data)
    case failed(E)
}
