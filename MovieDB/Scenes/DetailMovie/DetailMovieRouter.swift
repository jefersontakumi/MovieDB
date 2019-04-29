//
//  DetailMovieRouter.swift
//  MovieDB
//
//  Created by Administrador on 28/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation


protocol DetailMovieRoutingLogic
{
    
}

protocol DetailMovieDataPassing
{
    var dataStore: DetailMovieDataStore? { get }
}

class DetailMovieRouter: NSObject, DetailMovieRoutingLogic, DetailMovieDataPassing
{
    weak var viewController: DetailMovieVC?
    var dataStore: DetailMovieDataStore?
}
