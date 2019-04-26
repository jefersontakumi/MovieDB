//
//  ListMoviesRouter.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

protocol ListMoviesRoutingLogic
{
    
}

protocol ListMoviesDataPassing
{
    var dataStore: ListMoviesDataStore? { get }
}

class ListMoviesRouter: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing
{
    weak var viewController: ListMoviesVC?
    var dataStore: ListMoviesDataStore?
}
