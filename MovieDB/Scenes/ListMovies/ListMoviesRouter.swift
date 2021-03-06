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
    func routeToShowMovie(segue: UIStoryboard?, movie: Movie)
    func routeToShowGenre(segue: UIStoryboard?)
}

protocol ListMoviesDataPassing
{
    var dataStore: ListMoviesDataStore? { get set }
}

class ListMoviesRouter: NSObject, ListMoviesRoutingLogic, ListMoviesDataPassing
{
    weak var viewController: ListMoviesVC?
    var dataStore: ListMoviesDataStore?
    
    func routeToShowMovie(segue: UIStoryboard?, movie: Movie)
    {
        let destinationVC = segue?.instantiateViewController(withIdentifier: "ShowMovieViewController") as! DetailMovieVC
        var destinationDS = destinationVC.router!.dataStore!
        destinationDS.movie = movie
        viewController?.show(destinationVC, sender: nil)
    }
    
    func routeToShowGenre(segue: UIStoryboard?) {
        let destinationVC = segue?.instantiateViewController(withIdentifier: "ListGenresViewController") as! ListGenresVC
        destinationVC.listMovies = viewController
        viewController?.show(destinationVC, sender: nil)
    }
}
