//
//  MovieDBError.swift
//  MovieDB
//
//  Created by Administrador on 24/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

enum MovieDBError: Error {
    case badRequest(String)
    case parseError(String)
}
