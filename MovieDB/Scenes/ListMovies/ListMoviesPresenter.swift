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
    func presentFetchedMoviesPoster(response: ListMovies.FetchMovies.ResponsePoster)
    func showError(message: String)
}

class ListMoviesPresenter: ListMoviesPresentationLogic
{
    weak var viewController: ListMoviesDisplayLogic?
    
    func presentFetchedMovies(response: ListMovies.FetchMovies.Response)
    {
        var displayedMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie] = []
        displayedMovies = response.movies.map { (movie) in
            return ListMovies.FetchMovies.ViewModel.DisplayedMovie(id: movie.id, title: movie.title, url_image_banner: movie.backdropPath(size: .w500_and_h282_face))
        }
        viewController?.displayFetchedMovies(viewModel: displayedMovies)
    }
    
    func presentFetchedMoviesPoster(response: ListMovies.FetchMovies.ResponsePoster)
    {
        var displayedMovies: [String:[ListMovies.FetchMovies.ViewModel.DisplayedMovie]] = [:]
        
        for (key,value) in response.movies {
            displayedMovies[key] = value.map { (movie) in
                return ListMovies.FetchMovies.ViewModel.DisplayedMovie(id: movie.id, title: movie.title, url_image_banner: movie.posterPath(size: .w185))
            }
        }
        viewController?.displayFetchedMoviesPoster(viewModel: displayedMovies)
    }
    
    func showError(message: String) {
        viewController?.displayError(message: message)
    }
}
