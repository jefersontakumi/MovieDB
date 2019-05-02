//
//  DetailMoviePresenter.swift
//  MovieDB
//
//  Created by Administrador on 30/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol DetailMoviePresentationLogic
{
    func presentFetchedDetailMovie(response: DetailMovieModels.GetMovie.Response)
    func showError(message: String)
}

class DetailMoviePresenter: DetailMoviePresentationLogic
{
    weak var viewController: DetailMovieDisplayLogic?
    
    func presentFetchedDetailMovie(response: DetailMovieModels.GetMovie.Response)
    {
        let calendar = NSCalendar.current
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        let releaseYear = calendar.component(.year, from: dayFormatter.date(from:response.movie.release_date)!)
        
        
        let displayedMovie = DetailMovieModels.GetMovie.ViewModel.DisplayedDetailMovie(
            title: response.movie.title,
            url_image_backdrop: response.movie.backdropPath(size: .w500),
            url_image_poster: response.movie.posterPath(size: .w185),
            overview: response.movie.overview,
            release_year: releaseYear,
            video: response.movie.video
        )
        viewController?.displayFetchedMovie(viewModel: DetailMovieModels.GetMovie.ViewModel(displayedDetailMovie: displayedMovie))
    }
    
    func showError(message: String) {
        viewController?.displayError(message: message)
    }
}
