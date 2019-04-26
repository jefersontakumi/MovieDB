//
//  ListMoviesPresenter.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

protocol ListMoviesPresentationLogic
{
    func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
}

class ListMoviesPresenter: ListMoviesPresentationLogic
{
    weak var viewController: ListMoviesDisplayLogic?
    
    func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
    {
        var displayedMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
        
        displayedMovies = response.movies.map { (movie) in
            return ListMovies.FetchMovies.ViewModel.DisplayedMovie(id: movie.id, title: movie.title, url_image_banner: movie.posterPath(size: .w500_and_h282_face))
        }
        let viewModel = ListMovies.FetchMovies.ViewModel(displayedMovies: displayedMovies)
        viewController?.displayFetchedMovies(viewModel: viewModel)
    }
}
