//
//  ListGenresRouter.swift
//  MovieDB
//
//  Created by Administrador on 01/05/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol ListGenresRoutingLogic
{
    
}

protocol ListGenresDataPassing
{
    var dataStore: ListGenresDataStore? { get }
}

class ListGenresRouter: NSObject, ListGenresRoutingLogic, ListGenresDataPassing
{
    weak var viewController: ListGenresVC?
    var dataStore: ListGenresDataStore?
}
